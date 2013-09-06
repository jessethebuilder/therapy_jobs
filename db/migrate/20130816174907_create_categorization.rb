class CreateCategorization < ActiveRecord::Migration
  def change
    create_table :categorizations do |t|
      t.integer :category_id
      t.integer :job_id
      t.integer :user_id

      t.timestamps
    end
  end
end
