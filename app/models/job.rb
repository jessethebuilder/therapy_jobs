class Job < ActiveRecord::Base
  include CategoriesHelper

  attr_accessor :main_facility

  belongs_to :contact
  belongs_to :client

  has_many :job_locations
  has_many :facilities, :after_add => :add_main_facility,
           :before_remove => :remove_main_facility, :through => :job_locations

  has_one :categorization
  has_one :category, :through => :categorization

  validates :duration, :presence => true, :numericality => { :only_integer => true }
  validates :category, :presence => true

  #validates :main_facility_id, :presence => true
   #todo up and down
  after_create do
    #record_client_and_contact
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

  def client_id=(not_implemented)
    raise NotImplementedError
  end

  def self.of_this_client(client)
    where('client_id = ?', client.id).order("updated_at DESC")
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