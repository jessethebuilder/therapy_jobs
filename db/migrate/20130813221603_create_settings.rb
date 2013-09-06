class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :code
      t.string :name
      t.text :description
      t.text :aliases
      t.string :setting_defined_for_type
      t.integer :setting_defined_for_id

      t.timestamps
    end
  end
end
