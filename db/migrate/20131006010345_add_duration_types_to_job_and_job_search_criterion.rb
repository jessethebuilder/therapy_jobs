class AddDurationTypesToJobAndJobSearchCriterion < ActiveRecord::Migration
  def change
    add_column :jobs, :duration_type, :string
    add_column :job_search_criteria, :duration_types, :text
  end
end
