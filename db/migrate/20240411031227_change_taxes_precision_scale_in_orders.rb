class ChangeTaxesPrecisionScaleInOrders < ActiveRecord::Migration[7.1]
  def up
    change_column :orders, :taxes, :decimal, precision: 10, scale: 2
  end

  def down
    change_column :orders, :taxes, :decimal
  end
end
