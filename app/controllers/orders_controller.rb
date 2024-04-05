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
end
