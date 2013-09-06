# This migration comes from farm_address (originally 20130802162029)
class AddLabelToFarmAddressAddresses < ActiveRecord::Migration
  def change
    add_column :farm_address_addresses, :label, :string
  end
end

