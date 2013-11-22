module TherapyJobsDotCom
  include JobsHelper

  def to_tj_xml
    job_array = split_on_acceptable_categories_for_management
    xml = ''
    job_array.each do |job|
      xml += '<job>'
      h = job.send(:to_hash)
      h.each{ |k,v| xml += "<#{k}>#{v}</#{k}>"}
      xml += job.send(:bullet_points)
      xml += '</job>'
    end
    xml
  end

  private

  def to_hash
    a = main_facility.address
    h = {}
    h[:referencenumber] = id
    h[:date] = Date.today
    h[:title] = "#{this_category} for #{DURATION_TYPES[duration_type][:name].titlecase} position in #{a.city.titlecase}, #{a.state.upcase}."
    h[:description] = "<![CDATA[#{shared_description}]]>"
    h[:city] = a.city
    h[:state] = a.state
    h[:postalcode] = a.zip
    h[:specialty] = this_specialty
    h[:jobtype] = DURATION_TYPES[duration_type][:tj]
    h[:practicetype] = SETTINGS[setting_code][:tj]
    h[:contactprofile] = 'info'
    h
  end

  def this_category
    cat = acceptable_categories.first
    cat ? CATEGORIES[cat] : this_specialty
  end

  def this_specialty
    #specialty must be pt, ot, slp, pta, or cota
    CATEGORIES[category.code][:tj]
  end

  def bullet_points
    if read_attribute(:duration_type) == 'contract'
      bp_arr = contract_bullet_points
    elsif read_attribute(:duration_type) == 'perm'
      bp_arr = perm_bullet_points
    else
      raise ArgumentError, 'job_type must be travel or perm'
    end
    bp_str = ''
    bp_arr.each do |bp|
      bp_str += "<bulletpoint>#{bp}</bulletpoint>"
    end
    bp_str
  end

  def contract_bullet_points
    ["Competitive pay and full benefits", "Fully-furnished, comfortable housing included", "CEU reimbursement",
     "Licensing reimbursement"]
  end

  def perm_bullet_points
    ["Permanent, direct hire position", "Great pay and benefits"]
  end

end

class Job < ActiveRecord::Base
  include TherapyJobsDotCom
  include CategoriesHelper
  extend FarmerTown::ActiveRecordHelper

  attr_accessor :main_facility

  belongs_to :contact
  belongs_to :client

  has_many :job_locations
  has_many :facilities, :after_add => :add_main_facility,
           :before_remove => :remove_main_facility, :through => :job_locations

  has_one :categorization
  has_one :category, :through => :categorization

  #validates :duration, :presence => true, :numericality => { :only_integer => true }
  validates :duration_type, :presence => true, :inclusion => {:in => DURATION_TYPES.keys}
  validates :category, :presence => true
  validates :contact, :presence => true

  acts_like_an_array :acceptable_categories

  #validates :main_facility_id, :presence => true

  def main_facility
    Facility.find(main_facility_id)
  end

  def main_facility=(facility)
    self.facilities << facility unless self.facilities.include?(facility)
    write_attribute(:main_facility_id, facility.id)
  end

  def start_date
    read_attribute(:state_date) || Date.today
  end

  def setting_code
    main_facility.setting.code
  end

  def client_id=(not_implemented)
    raise NotImplementedError
  end

  def self.of_this_client(client)
    where('client_id = ?', client.id).order("updated_at DESC")
  end

  def normalize_categories
    self.acceptable_categories = [] if STANDARD_CATEGORIES.include?(category.code)
  end

  def split_on_acceptable_categories_for_management
    #returns an array of jobs for publication for job posting boards that only accept the standard categories as required fields
    #looks for values 'pt, ot, slp, pta, cota, all' in #acceptable_categories. Default is 'pt, ot, slp'
    these_jobs = []
    if STANDARD_CATEGORIES.include?(category.code)
      these_jobs << self
    else
      if acceptable_categories.blank?
        cats = %w|pt ot slp|
      elsif acceptable_categories == ['all']
        cats = %|pt ot slp pta cota|
      else
        cats = acceptable_categories
      end

      cats.each do |cat|
        new_job = self.dup
        new_job.acceptable_categories = [cat]
        new_job.category = category
        new_job.facilities = facilities
        these_jobs << new_job
      end
    end
    these_jobs
  end

  private

  def add_main_facility(facility)
    write_attribute(:main_facility_id, facility.id) unless self.main_facility_id
  end

  def remove_main_facility(facility)
    self.main_facility_id = nil if self.main_facility_id == facility.id
  end

  def record_client_and_contact
    write_attribute(:contact_id, main_facility.contact.id)
    write_attribute(:client_id, contact.client.id)
  end
end