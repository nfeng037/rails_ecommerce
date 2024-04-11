class AddTaxesToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :taxes, :decimal, precision: 10, scale: 2
  end
end
