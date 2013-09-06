# This migration comes from farm_address (originally 20130801193800)
class CreateFarmAddressAddresses < ActiveRecord::Migration
  def change
    create_table :farm_address_addresses do |t|
      t.integer :addressable_id
      t.string :addressable_type
      t.string :street
      t.string :street2
      t.string :street3
      t.string :city
      t.string :state
      t.string :zip

      t.float :latitude
      t.float :longitude

      t.boolean :spammable, :default => true

      t.timestamps
    end
  end
end
