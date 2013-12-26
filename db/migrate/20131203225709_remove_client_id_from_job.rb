class RemoveClientIdFromJob < ActiveRecord::Migration
  def change
    remove_column :jobs, :client_id, :integer
  end
end
