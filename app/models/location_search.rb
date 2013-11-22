class LocationSearch < ActiveRecord::Base
  belongs_to :job_search_criterion
  #todo spec
  has_one :address, :as => :addressable, :dependent => :destroy
  accepts_nested_attributes_for :address

  after_initialize do
    self.address = Address.new unless self.address
  end

  def express_address
    s = ''
    s += "#{address.city}, " if address.city
    s += "#{address.state} " if address.state
    s += "#{address.zip}" if address.zip
    s
  end

end
