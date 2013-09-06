class RemoveSettingFromFacility < ActiveRecord::Migration
  def change
    remove_column :facilities, :setting, :integer
  end
end
