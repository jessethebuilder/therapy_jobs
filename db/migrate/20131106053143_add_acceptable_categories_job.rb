class AddAcceptableCategoriesJob < ActiveRecord::Migration
  def change
    add_column :jobs, :acceptable_categories, :string
  end
end
