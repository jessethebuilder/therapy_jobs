json.array!(@clients) do |client|
  json.extract! client, :name, :phone, :email, :fax
  json.url client_url(client, format: :json)
end
