ActiveAdmin.register Order do
  permit_params :name, :address, :city, :postal_code, :phone_number, :province_id, :total_with_taxes, :status, order_items_attributes: [:id, :product_id, :quantity, :price, :_destroy]

  show do
    attributes_table do
      row :name
      row :address
      row :city
      row :postal_code
      row :phone_number
      row :province
      row :total_with_taxes do |order|
        number_to_currency order.total_with_taxes
      end
      row :status
    end

    panel "Order Items" do
      table_for order.order_items do
        column "Product" do |item|
          item.product.name
        end
        column "Quantity", :quantity
        column "Price" do |item|
          number_to_currency item.price
        end
        column "Subtotal" do |item|
          number_to_currency(item.quantity * item.price)
        end
      end
    end
    active_admin_comments
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :name
      f.input :address
      f.input :city
      f.input :postal_code
      f.input :phone_number
      f.input :province
      f.input :total_with_taxes
      f.input :status, as: :select, collection: Order.statuses.keys
    end
    f.has_many :order_items, allow_destroy: true do |n_f|
      n_f.input :product
      n_f.input :quantity
      n_f.input :price
    end
    f.actions
  end
end
