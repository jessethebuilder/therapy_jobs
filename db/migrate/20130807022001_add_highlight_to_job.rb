class AddHighlightToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :highlight, :text
  end
end
