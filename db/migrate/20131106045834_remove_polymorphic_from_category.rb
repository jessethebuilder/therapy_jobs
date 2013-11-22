class RemovePolymorphicFromCategory < ActiveRecord::Migration
  def change
    remove_column :jobs, :categorization_type, :string
    remove_column :jobs, :categorization_id, :integer
  end
end
