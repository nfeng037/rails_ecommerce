class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "order_id", "price", "product_id", "quantity", "updated_at"]
  end

  validates :order_id, :product_id, :quantity, :price, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :price, numericality: { greater_than_or_equal_to: 0.0 }
end
