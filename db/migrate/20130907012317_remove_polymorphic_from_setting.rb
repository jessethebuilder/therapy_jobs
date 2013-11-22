class RemovePolymorphicFromSetting < ActiveRecord::Migration
  def change
    remove_column :settings, :setting_defined_for_id, :integer
    remove_column :settings, :setting_defined_for_type, :string
  end
end
