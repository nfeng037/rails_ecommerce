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
      table_for user.orders.includes(order_items: [:product]) do
        column "Order ID", :id
        column "Created At", :created_at
        column "Products" do |order|
          ul do
            order.order_items.each do |item|
              subtotal = item.quantity * item.price
              li "#{item.product.name} - Quantity: #{item.quantity}, Price: #{number_to_currency(item.price)}, Subtotal: #{number_to_currency(subtotal)}"
            end
          end
        end
        column "Taxes", :taxes do |order|
          number_to_currency order.taxes
        end
        column "Total With Taxes", :total_with_taxes do |order|
          number_to_currency order.total_with_taxes
        end
      end
    end
    active_admin_comments
  end

  csv do
    column :id
    column :email
    column :created_at
    column "Orders" do |user|
      user.orders.map do |order|
        "Order ID: #{order.id}, Created At: #{order.created_at}, Total With Taxes: #{number_to_currency(order.total_with_taxes)}, Taxes: #{number_to_currency(order.taxes)}, Grand Total: #{number_to_currency(order.total_with_taxes + order.taxes)}"
      end.join("\n")
    end
  end
end
