class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  def total
    if product.active
      (product.price * 0.85) * quantity
    else
      product.price * quantity
    end
  end
end
