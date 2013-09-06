class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :code
      t.string :name
      t.text :description
      t.boolean :management
      t.text :aliases
      t.string :categorization_type
      t.integer :categorization_id

      t.timestamps
    end
  end
end
