class OrdersController < ApplicationController
  before_action :set_cart, only: [:new, :create, :update_summary]

  def new
    @order = Order.new
    set_default_taxes
  end

  def create
    @order = Order.new(order_params)
    @order.cart = @cart
    set_taxes(@order.province)

    @order.user = current_user if user_signed_in?
    @order.is_guest = !user_signed_in?

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
    params.require(:order).permit(:name, :address, :city, :postal_code, :province_id, :phone_number)
  end

  def set_default_taxes
    @taxes = { gst: 0, pst: 0, hst: 0 }
    @total_with_taxes = @cart.total
  end

  def set_taxes(province)
    total_price = @cart.total
    gst = province.gst_rate / 100.0 * total_price
    pst = province.pst_rate / 100.0 * total_price
    hst = province.hst_rate / 100.0 * total_price

    @taxes = { gst: gst, pst: pst, hst: hst }
    @total_with_taxes = total_price + gst + pst + hst
  end
end
