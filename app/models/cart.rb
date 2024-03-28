class Cart < ApplicationRecord
  has_many :cartItems
  has_many :products, through: :cartItems

  def total
    cartItems.to_a.sum { |cartItem| cartItem.total}
  end
end
