class AddStatesAndCategoriesToJobSearchCriterion < ActiveRecord::Migration
  def change
    add_column :job_search_criteria, :states, :text
    add_column :job_search_criteria, :categories, :text
  end
end
