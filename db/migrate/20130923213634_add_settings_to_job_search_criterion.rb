class AddSettingsToJobSearchCriterion < ActiveRecord::Migration
  def change
    add_column :job_search_criteria, :settings, :text
  end
end
