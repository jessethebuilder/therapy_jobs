json.array!(@contacts) do |contact|
  json.extract! contact, :phone, :phone2, :email, :email2, :client_id
  json.url contact_url(contact, format: :json)
end
