class AddSettingIdToFacility < ActiveRecord::Migration
  def change
    add_column :facilities, :setting_id, :integer
  end
end
