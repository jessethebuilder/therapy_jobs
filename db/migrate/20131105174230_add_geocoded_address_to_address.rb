class AddGeocodedAddressToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :geocoded_address, :string
    add_column :addresses, :country, :string
  end
end
