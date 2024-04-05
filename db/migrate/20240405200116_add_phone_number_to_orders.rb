class AddPhoneNumberToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :phone_number, :integer
  end
end
