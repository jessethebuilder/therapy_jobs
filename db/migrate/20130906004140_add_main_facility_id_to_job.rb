class AddMainFacilityIdToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :main_facility_id, :integer
  end
end
