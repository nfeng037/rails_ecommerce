ActiveAdmin.register Cart do
  actions :index, :show, :destroy

  index do
    selectable_column
    id_column
    column :created_at
    actions
  end

  show do
    panel "Cart Items" do
      table_for cart.cart_items.includes(:product) do
        column "Product" do |item|
          item.product.name
        end
        column :quantity
        column "Price" do |item|
          number_to_currency(item.product.price)
        end
        column "Total" do |item|
          number_to_currency(item.quantity * item.product.price)
        end
      end
    end
  end
end
