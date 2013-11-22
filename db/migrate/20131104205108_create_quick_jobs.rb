class CreateQuickJobs < ActiveRecord::Migration
  def change
    create_table :quick_jobs do |t|
      t.string :cats
      t.string :acceptable_cats
      t.string :setting_code
      t.string :duration_type
      t.string :street
      t.string :street2
      t.string :city
      t.string :state
      t.string :zip
      t.text :description
      t.text :private_description
      t.string :contact_string

      t.timestamps
    end
  end
end
