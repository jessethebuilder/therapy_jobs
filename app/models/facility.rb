class Facility < ActiveRecord::Base
  belongs_to :contact

  has_many :job_locations
  has_many :jobs, :through => :job_locations

  has_one :address, :as => :addressable, :class_name => 'FarmAddress::Address'

  has_one :setting, :as => :setting_defined_for

  validates :name, :presence => true
  validates :contact, :presence => true
  #validates :setting, :presence => true

  validate :this_address

  after_initialize do
    self.address = FarmAddress::Address.new unless self.address
  end

  private

  def this_address
    errors.add(:address, 'City cannot be blank.') unless self.address.city
    errors.add(:address, 'State cannot be blank.') unless self.address.state
    errors.add(:address, 'State is not in list.') unless  FarmAddress::STATES.keys.include?(self.address.state)
  end
end