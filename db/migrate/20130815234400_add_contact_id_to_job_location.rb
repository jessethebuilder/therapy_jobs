class AddContactIdToJobLocation < ActiveRecord::Migration
  def change
    add_column :job_locations, :contact_id, :integer
  end
end
