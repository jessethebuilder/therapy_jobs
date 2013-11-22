class AddAddressStringToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :address_string, :string
  end
end
