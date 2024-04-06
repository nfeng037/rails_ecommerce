class CartController < ApplicationController
  def show
    @render_cart = false
    @cart = current_cart
  end

  def add
    @product = Product.find_by(id: params[:id])
    quantity = params[:quantity].to_i

    current_cart_item= @cart.cart_items.find_by(product_id: @product.id)

    if current_cart_item
      new_quantity = current_cart_item.quantity + quantity
      update_success = current_cart_item.update(quantity: new_quantity)
    else
      @cart.cart_items.create(product: @product, quantity: quantity)
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [turbo_stream.replace('cart', partial: 'cart/cart', locals: { cart: @cart}),
                              turbo_stream.replace('cart_quantity', partial: 'cart/cart_quantity', locals: {cart: @cart})]
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
        render turbo_stream: [turbo_stream.replace('cart', partial: 'cart/cart', locals: { cart: @cart}),
                              turbo_stream.replace('cart_quantity', partial: 'cart/cart_quantity', locals: {cart: @cart})]
      end
    end
  end

  def remove
    CartItem.find_by(id: params[:id]).destroy

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [turbo_stream.replace('cart', partial: 'cart/cart', locals: { cart: @cart}),
                              turbo_stream.replace('cart_quantity', partial: 'cart/cart_quantity', locals: {cart: @cart})]
      end
    end
  end
end
