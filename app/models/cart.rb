class Cart < ApplicationRecord
  has_many :cart_items
  has_many :products, through: :cart_items
  has_one :order

  def total
    cart_items.to_a.sum { |cart_item| cart_item.total }
  end
end
