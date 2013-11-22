class CreateLocationSearches < ActiveRecord::Migration
  def change
    create_table :location_searches do |t|
      t.float :search_radius
      t.boolean :active, :default => true
      t.integer :job_search_criterion_id

      t.timestamps
    end
  end
end
