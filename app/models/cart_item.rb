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

  def self.ransackable_associations(auth_object = nil)
    ["cart", "product"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["cart_id", "created_at", "id", "id_value", "product_id", "quantity", "updated_at"]
  end

  validates :product_id, :cart_id, :quantity, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
end
