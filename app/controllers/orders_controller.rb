class OrdersController < ApplicationController
  before_action :set_cart, only: [:new, :create, :update_summary]

  def index
    if user_signed_in?
      @orders = current_user.orders.includes(order_items: :product).order(created_at: :desc)
    else
      @orders = Order.where(id: session[:order_ids]).includes(order_items: :product).order(created_at: :desc)
    end
  end


  def new
    @order = Order.new
    set_default_taxes
    @address = current_user.address if user_signed_in?
    Rails.logger.debug "Address: #{@address.inspect}"
  end


  def create
    Rails.logger.debug "Submitted params: #{params.inspect}"
    @order = Order.new(order_params)
    @order.user = current_user if user_signed_in?
    @order.is_guest = !user_signed_in?

    if user_signed_in? && current_user.address.present?
      set_order_details_from_address(current_user.address)
    end

    if @order.province_id.present?
      set_taxes(@order.province_id)
      @order.total_with_taxes = @total_with_taxes
      @order.taxes = @taxes.values.sum
    end

    if @order.save
      unless user_signed_in?
        session[:order_ids] ||= []
        session[:order_ids] << @order.id
      end

      @cart.cart_items.each do |item|
        price = item.product.active ? item.product.price * 0.85 : item.product.price
        @order.order_items.create!(
          product_id: item.product_id,
          quantity: item.quantity,
          price: price
        )
      end

      redirect_to payments_new_path(order_id: @order.id), notice: 'Order was successfully created.'
    else
      render :new
    end
  end


  def update_summary
    province_id = params[:order][:province_id]
    set_taxes(province_id)
    total_price = @cart.cart_items.inject(0) { |sum, item| sum + item.quantity * item.product.price }
    total_with_taxes = total_price + @taxes.values.sum

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("tax_summary",
          partial: "orders/order_summary",
          locals: { taxes: @taxes, total_with_taxes: @total_with_taxes })
      end
    end
  end

  def show
    @order = Order.find(params[:id])
    set_taxes(@order.province)
  end

  private

  def set_cart
    @cart = current_cart
  end

  def order_params
    params.require(:order).permit(:name, :address, :city, :postal_code, :phone_number, :province_id, :total_with_taxes, :taxes)
  end

  def set_order_details_from_address(address)
    @order.name = address.name
    @order.address = address.address_line
    @order.city = address.city
    @order.postal_code = address.postal_code
    @order.phone_number = address.phone_number
    @order.province_id = address.province_id
  end

  def set_default_taxes
    @taxes = { gst: 0, pst: 0, hst: 0 }
    @total_with_taxes = @cart.total
  end

  def set_taxes(province_id)
    Rails.logger.debug "Setting taxes for province ID: #{province_id}"
    province = Province.find_by(id: province_id)
    return set_default_taxes unless province

    total_price = @cart.total
    @taxes = {
      gst: province.gst_rate / 100.0 * total_price,
      pst: province.pst_rate / 100.0 * total_price,
      hst: province.hst_rate / 100.0 * total_price
    }
    @total_with_taxes = total_price + @taxes.values.sum
  end
end
