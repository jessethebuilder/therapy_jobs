class AddMustBeCompleteToJobFormSource < ActiveRecord::Migration
  def change
    add_column :job_form_sources, :must_be_complete, :boolean
  end
end
