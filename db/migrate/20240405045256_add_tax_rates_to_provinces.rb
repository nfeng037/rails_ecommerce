class AddTaxRatesToProvinces < ActiveRecord::Migration[7.1]
  def change
    add_column :provinces, :hst_rate, :decimal
  end
end
