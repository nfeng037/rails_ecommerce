class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :province, null: false, foreign_key: true
      t.string :adress_line
      t.string :city
      t.string :postal_code

      t.timestamps
    end
  end
end
