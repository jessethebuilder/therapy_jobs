class Job < ActiveRecord::Base
  include CategoriesHelper

  belongs_to :contact
  belongs_to :client

  has_many :job_locations
  has_many :facilities, :through => :job_locations

  has_one :categorization
  has_one :category, :through => :categorization

  validates :duration, :presence => true, :numericality => { :only_integer => true }
  validates :category, :presence => true
  #validates :contact, :presence => true

  validate :at_least_one_facility

  before_create do
    record_client_and_contact
    self.main_facility_id = self.facilities.first
  end

  #def main_facility
  #  Facility.find(main_facility_id)
  #end
  ##todo spec facility
  #def main_facility=(facility)
  #  update_attribute(:main_facility_id, facility.id)
  #  self.facilities << facility
  #end

  def start_date
    read_attribute(:state_date) || Date.today
  end

  def client_id=(not_implemented)
    raise NotImplementedError
  end

  def self.of_this_client(client)
    where('client_id = ?', client.id).order("updated_at DESC")
  end

  def self.category_join
    Job.joins(:category)
  end

  def self.with_these_categories(*category_codes)
    self.category_join.where(:categories => {:code => category_codes})
  end

  def highlight
    read_attribute(:highlight) || facilities[0].description
  end

  private

  def record_client_and_contact
    write_attribute(:contact_id, facilities[0].contact.id)
    write_attribute(:client_id, contact.client.id)
  end

  def at_least_one_facility
    errors.add(:facilities, 'must have at least one location.') if self.facilities.empty?
  end

end