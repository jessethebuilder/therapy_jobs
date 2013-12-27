class LocationSearch < ActiveRecord::Base
  belongs_to :job_search_criterion

  has_one :address, :as => :addressable, :dependent => :destroy
  accepts_nested_attributes_for :address

  after_initialize do
    self.address = Address.new unless self.address
  end

  validates :search_radius, :presence => true,
                            :numericality => {:only_integer => true, :greater_than_or_equal_to => 1, :allow_nil => true}

  validate :address_string_exists, :address_string_parses
  private
  def address_string_exists
    errors.add :address, "Location required.".html_safe unless address.geocode
  end

  def address_string_parses
    errors.add :address, "Could not locate <strong>#{address.address_string}</strong>.".html_safe unless address.geocode
  end
  public

  def address_string
    address.address_string
  end

  def express_address
    s = ''
    s += "#{address.city}, " if address.city
    s += "#{address.state} " if address.state
    s += "#{address.zip}" if address.zip
    s
  end

end
