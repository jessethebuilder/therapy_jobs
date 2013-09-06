json.array!(@categories) do |category|
  json.extract! category, :code, :name, :description, :management, :aliases
  json.url category_url(category, format: :json)
end
