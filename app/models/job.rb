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

  has_one :address, :as => :addressable

  attr_accessor :main_facility

  belongs_to :contact

  has_many :job_locations
  has_many :facilities, :after_add => :add_main_facility, :before_remove => :remove_main_facility,
             :through => :job_locations

  has_one :categorization
  has_one :category, :through => :categorization

  #validates :duration, :presence => true, :numericality => { :only_integer => true }
  validates :duration_type, :presence => true, :inclusion => {:in => DURATION_TYPES.keys}
  validates :category, :presence => true
  validates :contact, :presence => true

  acts_like_an_array :acceptable_categories, :benefits, :requirements, :desirements, :acceptable_categories

  #todo this is important. needs to validate that a facility exists
  #validates :main_facility_id, :presence => true

  def client
    contact.client
  end

  def licensed_categories
    if category.standard?
      category.name
    else
      categories_for_management.to_sentence(:last_word_connector => ', or ')
    end
  end

  def categories_for_management
    if acceptable_categories == ['all']
      cats = STANDARD_CATEGORIES
    elsif acceptable_categories == ['assistants']
      cats = %w|pta cota|
    elsif acceptable_categories == ['therapists']
      cats = %w|pt ot slp|
    else
      cats = acceptable_categories
    end
    arr = []
    cats.each do |c|
      arr << CATEGORIES[c.downcase][:name]
    end
    arr
  end

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

  def city_state
    s = main_facility.address.city.titlecase
    s += ", "
    s += main_facility.address.state.upcase
    s
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