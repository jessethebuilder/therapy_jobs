class AddSettingToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :setting, :string
  end
end
