class CreateJobForms < ActiveRecord::Migration
  def change
    create_table :job_forms do |t|
      t.text :q_a_hash
      t.integer :job_form_source_id
      t.integer :user_id

      t.timestamps
    end
  end
end
