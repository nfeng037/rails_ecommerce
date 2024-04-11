ActiveAdmin.register Order do
  permit_params :name, :address, :city, :postal_code, :phone_number, :province_id, :status, :payment_intent_id, :total_with_taxes, :taxes, :user_id, :is_guest

  index do
    selectable_column
    id_column
    column :name
    column :address
    column :city
    column :postal_code
    column :phone_number
    column :total_with_taxes
    column :taxes
    column :created_at
    column :status do |order|
      order.status
    end
    actions
  end

  filter :name
  filter :address
  filter :city
  filter :postal_code
  filter :status
  filter :created_at

  show do
    attributes_table do
      row :name
      row :address
      row :city
      row :postal_code
      row :phone_number
      row :province_id
      row :user_id
      row :is_guest
      row :status do |order|
        order.status
      end
      row :payment_intent_id
      row :total_with_taxes
      row :taxes
      row :created_at
      row :updated_at
    end

    panel "Cart Items" do
      table_for order.cart.cart_items do
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

  form do |f|
    f.inputs "Order Details" do
      f.input :name
      f.input :address
      f.input :city
      f.input :postal_code
      f.input :phone_number
      f.input :province_id, as: :select, collection: Province.all.collect { |p| [p.name, p.id] }
      f.input :user_id, as: :select, collection: User.all.collect { |u| [u.email, u.id] }
      f.input :is_guest
      f.input :status, as: :select, collection: Order.statuses.keys.map { |status| [status, status] }
      f.input :payment_intent_id
      f.input :total_with_taxes
      f.input :taxes
    end
    f.actions
  end

end
