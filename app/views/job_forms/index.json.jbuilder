json.array!(@job_forms) do |job_form|
  json.extract! job_form, :name, :content, :category_id, :company_id
  json.url job_form_url(job_form, format: :json)
end
