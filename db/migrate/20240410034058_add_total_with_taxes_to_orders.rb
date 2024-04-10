class AddTotalWithTaxesToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :total_with_taxes, :decimal
  end
end
