class OrdersController < ApplicationController
  def new
    @order = Order.new
    if user_signed_in?
      @addresses = current_user.addresses
    else
      @addresses = []
    end
  end

  def show
    @order = Order.find(params[:id])

    cart = @order.cart
    total_price = cart.total

    province = @order.province

    gst = province.gst_rate / 100.0 * total_price
    pst = province.pst_rate / 100.0 * total_price
    hst = province.hst_rate / 100.0 * total_price

    @taxes = { gst: gst, pst: pst, hst: hst }
    @total_with_taxes = total_price + gst + pst + hst
  end

  def create
    @order = Order.new(order_params)

    @order.user = current_user if user_signed_in?
    @order.is_guest = !user_signed_in?

    @order.cart = current_cart

    if @order.save
      redirect_to @order, notice: 'Order was successfully created.'
    else
      flash.now[:alert] = @order.errors.full_messages.to_sentence
      @provinces = Province.all
      render :new
    end
  end

  private
    def order_params
      params.require(:order).permit(:province_id, :cart_id, :address, :name, :phone_number, :city, :postal_code, :is_guest)
    end
end
