class AddIsGuestToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :is_guest, :boolean, default: false
  end
end
