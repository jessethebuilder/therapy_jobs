json.array!(@facilities) do |facility|
  json.extract! facility, :name, :contact_id
  json.url facility_url(facility, format: :json)
end
