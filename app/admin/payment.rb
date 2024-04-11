ActiveAdmin.register Payment do
  permit_params :order_id, :amount, :payment_date, :status

  index do
    selectable_column
    id_column
    column :order_id
    column :amount
    column :payment_date
    column :status do |payment|
      payment.status.titleize
    end
    column :created_at
    actions
  end

  filter :order_id
  filter :status
  filter :payment_date

  show do
    attributes_table do
      row :order do |payment|
        link_to payment.order.id, admin_order_path(payment.order) if payment.order
      end
      row :amount
      row :payment_date
      row :status do |payment|
        payment.status.titleize
      end
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :order_id, as: :select, collection: Order.all.collect { |o| [o.id, o.id] }
      f.input :amount
      f.input :payment_date, as: :datepicker
      f.input :status, as: :select, collection: Payment.statuses.keys.map { |status| [status.titleize, status] }
    end
    f.actions
  end
end
