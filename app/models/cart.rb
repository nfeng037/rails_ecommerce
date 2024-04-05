class Cart < ApplicationRecord
  has_many :cartItems
  has_many :products, through: :cartItems
  has_one :order

  def total
    cartItems.to_a.sum { |cartItem| cartItem.total}
  end
end
