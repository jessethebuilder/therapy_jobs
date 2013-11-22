class Address < ActiveRecord::Base

  belongs_to :addressable, :polymorphic => true
  geocoded_by :unformatted
  reverse_geocoded_by :latitude, :longitude, :address => :geocoded_address

  #matchable :street, :street2, :street3, :city, :state

  def unformatted
    if address_string
      #hack relates to #geocode_address
      s = address_string
    else
      s = ''
      s += "#{self.street}\n" if self.street
      s += "#{self.street2.titleize}\n" if self.street2
      s += "#{self.street3.titleize}\n" if self.street3
      s += "#{self.city.titleize}, " if self.city
      s += "#{self.state.titleize} " if self.state
      s +=  self.zip if self.zip
    end
    s
  end

  def full_state
    STATES[self.state]
  end

  def label
    addressable.name
  end

  def ===(other_address)
    match = true
    [:street, :street2, :street3, :city, :state].each do |attr|
      a_attr_val = send(attr)
      other_address_attr_val = other_address.send(attr)
      a_attr_val.downcase if a_attr_val.class == String
      other_address_attr_val.downcase if a_attr_val.class == String
      match = false unless a_attr_val == other_address_attr_val
      break if match == false
    end
    match
  end

  def Address.geocode_string(address_string)
    a = self.new()
    a.send(:address_string=, address_string)
    a.geocode
    [a.latitude, a.longitude] == [nil, nil] ? nil : [a.latitude, a.longitude]
  end

  def Address.extract_zip_from_string(address_string)
    /, [A-Z][A-Z] (\d{5})/ =~ address_string
    $1
  end

  STATES = {'al' => 'Alabama', 'ak' => 'Alaska', 'az' => 'Arizona', 'ar' => 'Arkansas', 'ca' => 'California', 'co' => 'Colorado', 'ct' => 'Connecticut', 'dc' => 'District of Columbia', 'de' => 'Delaware', 'fl' => 'Florida', 'ga' => 'Georgia', 'hi' => 'Hawaii', 'id' => 'Idaho', 'il' => 'Illinois', 'in' => 'Indiana', 'ia' => 'Iowa', 'ks' => 'Kansas', 'ky' => 'Kentucky', 'la' => 'Louisiana', 'me' => 'Maine', 'md' => 'Maryland', 'ma' => 'Massachusetts', 'mi' => 'Michigan', 'mn' => 'Minnesota', 'ms' => 'Mississippi', 'mo' => 'Missouri', 'mt' => 'Montana', 'ne' => 'Nebraska', 'nv' => 'Nevada', 'nh' => 'New Hampshire', 'nj' => 'New Jersey', 'nm' => 'New Mexico', 'ny' => 'New York', 'nc' => 'North Carolina', 'nd' => 'North Dakota', 'oh' => 'Ohio', 'ok' => 'Oklahoma', 'or' => 'Oregon', 'pa' => 'Pennsylvania', 'ri' => 'Rhode Island', 'sc' => 'South Carolina', 'sd' => 'South Dakota', 'tn' => 'Tennessee', 'tx' => 'Texas', 'ut' => 'Utah', 'vt' => 'Vermont', 'va' => 'Virginia', 'wa' => 'Washington', 'wv' => 'West Virginia', 'wi' => 'Wisconsin', 'wy' => 'Wyoming'}
end