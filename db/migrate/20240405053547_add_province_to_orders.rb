class AddProvinceToOrders < ActiveRecord::Migration[7.1]
  def change
    add_reference :orders, :province, null: false, foreign_key: true
  end
end
