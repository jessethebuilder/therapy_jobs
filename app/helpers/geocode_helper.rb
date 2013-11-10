module GeocodeHelper
  def basic_address
    s = ''
    s += "#{street}, " if street
    s += "#{city}, " if city
    s += "#{state} " if state
    s += zip if zip
    s
  end
end