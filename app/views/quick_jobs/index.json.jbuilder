json.array!(@quick_jobs) do |quick_job|
  json.extract! quick_job, :category, :address1, :address2, :city, :state, :zip, :setting, :description
  json.url quick_job_url(quick_job, format: :json)
end
