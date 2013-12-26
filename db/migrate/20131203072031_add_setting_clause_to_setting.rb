class AddSettingClauseToSetting < ActiveRecord::Migration
  def change
    add_column :settings, :setting_clause, :string
  end
end
