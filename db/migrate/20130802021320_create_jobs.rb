class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.text :benefits
      t.text :requirements
      t.text :desirements
      t.float :required_experience
      t.float :desired_experience
      t.datetime :start_date
      t.integer :duration
      t.float :pay_rate

      t.integer :contact_id

      t.timestamps
    end
  end
end
