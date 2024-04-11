ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation

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
      table_for user.orders.includes(order_items: :product) do
        column "Order ID", :id
        column "Created At", :created_at
        column "Total With Taxes", :total_with_taxes do |order|
          number_to_currency order.total_with_taxes
        end
        column "Products" do |order|
          ul do
            order.order_items.each do |item|
              li "#{item.product.name} - Quantity: #{item.quantity}, Price: #{number_to_currency(item.price)}"
            end
          end
        end
      end
    end
    active_admin_comments
  end
end
