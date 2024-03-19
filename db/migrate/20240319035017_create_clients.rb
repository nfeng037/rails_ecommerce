class CreateClients < ActiveRecord::Migration[7.1]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :address
      t.string :email
      t.string :phone_number
      t.string :hassed_and_salted_password

      t.timestamps
    end
  end
end
