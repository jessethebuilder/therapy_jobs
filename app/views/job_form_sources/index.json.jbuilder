json.array!(@job_form_sources) do |job_form_source|
  json.extract! job_form_source, :name, :content, :category_id, :company_id
  json.url job_form_source_url(job_form_source, format: :json)
end
