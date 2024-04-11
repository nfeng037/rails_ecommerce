class ChangeTotalPrecisionScaleInOrders < ActiveRecord::Migration[7.1]
  def up
    change_column :orders, :total_with_taxes, :decimal, precision: 10, scale: 2
  end

  def down
    change_column :orders, :total_with_taxes, :decimal
  end
end
