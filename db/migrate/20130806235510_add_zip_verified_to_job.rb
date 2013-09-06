class AddZipVerifiedToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :zip_verified, :boolean, :default => false
  end
end
