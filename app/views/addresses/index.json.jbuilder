json.array!(@addresses) do |address|
  json.extract! address, :addressable_id, :addressable_type, :street, :street2, :street3, :city, :state, :zip, :latitude, :longitude, :spammable
  json.url address_url(address, format: :json)
end
