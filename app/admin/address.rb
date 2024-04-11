ActiveAdmin.register Address do
  permit_params :user_id, :province_id, :address_line, :city, :postal_code, :name, :phone_number

  index do
    selectable_column
    id_column
    column :user
    column :province
    column :address_line
    column :city
    column :postal_code
    column :name
    column :phone_number
    actions
  end

  filter :user
  filter :province
  filter :city
  filter :postal_code

  form do |f|
    f.inputs "Address Details" do
      f.input :user
      f.input :province, as: :select, collection: Province.all.map { |p| [p.name, p.id] }
      f.input :address_line
      f.input :city
      f.input :postal_code
      f.input :name
      f.input :phone_number
    end
    f.actions
  end

  show do
    attributes_table do
      row :user
      row :province
      row :address_line
      row :city
      row :postal_code
      row :name
      row :phone_number
    end
  end
end
