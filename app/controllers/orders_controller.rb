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

    Rails.logger.info("Current user: #{current_user.inspect}")
    Rails.logger.info("Current cart: #{current_cart.inspect}")

    if user_signed_in?
      @order.user = current_user
    else
      guest_user = User.create(guest: true)
      @order.user = guest_user if guest_user.persisted?
    end

    @order.cart = current_cart

    if @order.save
      redirect_to @order, notice: 'Order was successfully created.'
    else
      guest_user = User.new(guest: true)
      if guest_user.save
        @order.user = guest_user
      else
        Rails.logger.info(guest_user.errors.full_messages)
        @order.errors.add(:base, "Failed to create guest user")
        render :new
      end
    end
  end

  private
    def order_params
      params.require(:order).permit(:province_id, :cart_id, :address, :city, :postal_code)
    end
end
