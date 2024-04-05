class ChangePhoneNumberToStringInOrders < ActiveRecord::Migration[7.1]
  def change
    change_column :orders, :phone_number, :string
  end
end
