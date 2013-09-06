class RemoveTitleFromJob < ActiveRecord::Migration
  def up
    remove_column :jobs, :title
  end

  def down
    add_column :jobs, :title, :string
  end
end
