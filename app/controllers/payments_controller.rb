class PaymentsController < ApplicationController
  before_action :set_order

  def new
    if @order.nil? || (!@order.is_guest && @order.user != current_user)
      redirect_to root_path, alert: 'Unauthorized access!'
    end

    @amount = calculate_order_amount
  end

  def create
    begin
      @payment_intent = Stripe::PaymentIntent.create(
        amount: calculate_order_amount,
        currency: 'cad',
        metadata: { order_id: @order.id }
      )

      payment = Payment.create(order: @order, status: :processing)

      @order.update(payment_intent_id: @payment_intent.id)
      payment.update(status: :successful)

      if @order.update(status: :paid)
        Payment.create(order: @order, status: :successful, amount: @order.total_with_taxes, payment_date: Time.current)
        @order.cart.cart_items.destroy_all
      else
        redirect_to payments_new_path(order_id: @order.id), alert: "Unable to update order status."
      end

      redirect_to payments_success_path(order_id: @order.id), notice: "Payment was initiated successfully."
    rescue Stripe::StripeError => e
      payment.update(status: :failed) if payment
      redirect_to payment_path(@order), alert: e.message
    end
  end



  def cancel
    redirect_to new_order_path(order_id: @order.id), alert: "Payment was cancelled."
  end

  def success
    if @order.update(status: :paid)
      Payment.create(
        order: @order,
        status: :successful,
        amount: @order.total_with_taxes,
        payment_date: Time.current)
    else
      redirect_to payments_new_path(order_id: @order.id), alert: "Unable to update order status."
    end
  end


  private

  def set_order
    @order = Order.find(params[:order_id])
  end

  def calculate_order_amount
    (@order.total_with_taxes * 100).to_i
  end
end
