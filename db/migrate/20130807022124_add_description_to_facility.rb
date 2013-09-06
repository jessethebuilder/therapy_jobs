class AddDescriptionToFacility < ActiveRecord::Migration
  def change
    add_column :facilities, :description, :text
  end
end
