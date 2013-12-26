class AddProfessionToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :profession, :string
  end
end
