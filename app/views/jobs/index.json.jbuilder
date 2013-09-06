json.array!(@jobs) do |job|
  json.extract! job, :title, :description, :benefits, :requirements, :desirements, :required_experience, :desired_experience, :start_date, :duration, :pay_rate
  json.url job_url(job, format: :json)
end
