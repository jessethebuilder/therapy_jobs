class CreateJobFormSources < ActiveRecord::Migration
  def change
    create_table :job_form_sources do |t|
      t.string :name
      t.text :content
      t.integer :category_id
      t.integer :client_id
      t.integer :contact_id

      t.timestamps
    end
  end
end
