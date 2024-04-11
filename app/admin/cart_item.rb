ActiveAdmin.register CartItem do
  permit_params :product_id, :cart_id, :quantity

  index do
    selectable_column
    id_column
    column :cart
    column :product
    column :quantity
    actions
  end

  filter :cart
  filter :product

  form do |f|
    f.inputs "CartItem Details" do
      f.input :cart
      f.input :product, as: :select, collection: Product.all.map { |p| [p.name, p.id] }
      f.input :quantity
    end
    f.actions
  end

  show do
    attributes_table do
      row :cart
      row :product
      row :quantity
    end
  end
end
