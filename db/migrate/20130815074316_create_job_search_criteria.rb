class CreateJobSearchCriteria < ActiveRecord::Migration
  def change
    create_table :job_search_criteria do |t|
      t.text :order_on
      t.text :search_on
      t.text :recent_jobs
      t.boolean :include_management
      t.integer :user_id
      t.boolean :temporary, :default => false

      t.timestamps
    end
  end
end
