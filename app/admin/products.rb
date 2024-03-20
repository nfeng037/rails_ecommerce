ActiveAdmin.register Product do

  permit_params :name, :description, :price, :stock, :category_id, :active, :image

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :price
    column :stock
    column :active
    column :category_id
    column "Image" do |product|
      if product.image.attached?
        image_tag product.image, width: "50px", height: "50px"
      else
        "No Image"
      end
    end
    actions
  end

  filter :name
  filter :active
  filter :price
  filter :stock
  filter :category_id

  form do |f|
    f.inputs do
      f.input :name
      f.input :category_id
      f.input :description
      f.input :price
      f.input :stock
      f.input :active
      f.input :image, as: :file, hint: f.object.image.attached? ? "Current image: #{f.object.image.filename}" : ''
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :price
      row :stock
      row :active
      row :category_id
      row :image do |product|
        if product.image.attached?
          image_tag url_for(product.image), width: "200px", height: "200px"
        end
      end
    end
  end

end
