class CreateFacilities < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
      t.string :name
      t.string :setting
      t.integer :contact_id

      t.timestamps
    end
  end
end
