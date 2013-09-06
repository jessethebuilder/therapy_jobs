class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :title
      t.string :phone
      t.string :phone2
      t.string :email
      t.string :email2
      t.integer :client_id

      t.timestamps
    end
  end
end
