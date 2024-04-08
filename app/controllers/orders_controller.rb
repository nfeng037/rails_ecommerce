class OrdersController < ApplicationController
  before_action :set_cart, only: [:new, :create, :update_summary]

  def new
    @order = Order.new
    set_default_taxes
    @address = current_user.address if user_signed_in?
    Rails.logger.debug "Address: #{@address.inspect}"
  end


  def create
    Rails.logger.debug "Submitted params: #{params.inspect}"
    @order = Order.new(order_params)
    @order.cart = @cart
    @order.user = current_user if user_signed_in?
    @order.is_guest = !user_signed_in?

    if user_signed_in? && current_user.address.present?
      set_order_details_from_address(current_user.address)
    end

    set_taxes(@order.province_id) if @order.province_id.present?

    if @order.save
      redirect_to payment_order_path(@order), notice: 'Order was successfully created.'
    else
      render :new
    end
  end

  def update_summary
    @order = Order.new(order_params)
    @order.cart = @cart
    set_taxes(Province.find(@order.province_id))

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
    params.require(:order).permit(:name, :address, :city, :postal_code, :phone_number, :province_id)
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
