class RemoveSettingFromJob < ActiveRecord::Migration
  def up
    remove_column :jobs, :setting
  end

  def down
    add_column :jobs, :setting, :string
  end
end
