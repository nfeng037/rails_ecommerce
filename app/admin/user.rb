ActiveAdmin.register User do
  permit_params :email

  index do
    selectable_column
    id_column
    column :email
    column :created_at

    actions
  end

  show do
    attributes_table do
      row :email
      row :created_at
    end

    panel "Orders" do
      table_for user.orders.includes(cart: {cart_items: :product}) do
        column "Order ID", :id
        column "Created At", :created_at
        column "Total With Taxes" do |order|
          number_to_currency(order.total_with_taxes)
        end
        column "Products" do |order|
          products_list = order.cart.cart_items.map do |item|
            "#{item.product.name} (#{item.quantity})"
          end
          products_list.join(", ")
        end
        column "Taxes", :taxes do |order|
          number_to_currency(order.taxes)
        end
      end
    end

    active_admin_comments
  end

end
