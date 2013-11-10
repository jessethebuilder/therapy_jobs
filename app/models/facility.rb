class Facility < ActiveRecord::Base
  include AddressesHelper

  belongs_to :contact
  belongs_to :setting

  has_many :job_locations
  has_many :jobs, :through => :job_locations

  has_one :address, :as => :addressable, :dependent => :destroy

  validates :name, :presence => true
  validates :contact, :presence => true
  validates :setting, :presence => true

  validates :address, :presence => true
  validate :this_address

  before_save do
    geocode_address
  end

  after_initialize do
    self.address = Address.new unless self.address
  end

  def self.address_join
    self.joins(:address)
  end

  def ===(other_facility)
    address === other_facility.address && contact == other_facility.contact
  end

  private

  def this_address
    errors.add(:address, 'City cannot be blank.') unless self.address.city
    errors.add(:address, 'State cannot be blank.') unless self.address.state
    errors.add(:address, 'State is not in list.') unless  Address::STATES.keys.include?(self.address.state)
  end


end