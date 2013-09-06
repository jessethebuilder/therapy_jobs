class CreateJobLocations < ActiveRecord::Migration
  def change
    create_table :job_locations do |t|
      t.integer :facility_id
      t.integer :job_id
    end
  end
end
