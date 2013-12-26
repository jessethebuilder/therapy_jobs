class AddPrivateDescriptionToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :private_description, :string
  end
end
