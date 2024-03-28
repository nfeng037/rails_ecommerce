class CartController < ApplicationController
  def show
    @render_cart = false
  end

  def add
    @product = Product.find_by(id: params[:id])
    quantity = params[:quantity].to_i

    current_cartItem= @cart.cartItems.find_by(product_id: @product.id)

    if current_cartItem
      new_quantity = current_cartItem.quantity + quantity
      update_success = current_cartItem.update(quantity: new_quantity)
    else
      @cart.cartItems.create(product: @product, quantity: quantity)
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [turbo_stream.replace('cart', partial: 'cart/cart', locals: { cart: @cart})]
      end
    end

  end

  def decrease
    cart_item = CartItem.find_by(id: params[:id])
    if cart_item && cart_item.quantity > 1
      cart_item.update(quantity: cart_item.quantity - 1)
    else
      cart_item.destroy
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [turbo_stream.replace('cart', partial: 'cart/cart', locals: { cart: @cart})]
      end
    end
  end

  def remove
    CartItem.find_by(id: params[:id]).destroy

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [turbo_stream.replace('cart', partial: 'cart/cart', locals: { cart: @cart})]
      end
    end
  end
end
