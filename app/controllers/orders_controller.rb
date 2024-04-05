class OrdersController < ApplicationController
  def new
    @order = Order.new
    if user_signed_in?
      @addresses = current_user.addresses
    else
      @addresses = []
    end
  end
end
