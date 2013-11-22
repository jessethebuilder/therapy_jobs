class CreateAddresses < ActiveRecord::Migration
  def change
    drop_table :farm_address_addresses

    create_table :addresses do |t|
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
      t.boolean :spammable

      t.timestamps
    end
  end
end
