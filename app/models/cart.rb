class Cart < ApplicationRecord
  has_many :cart_items
  has_many :products, through: :cart_items
  has_one :order

  def total
    cart_items.to_a.sum { |cart_item| cart_item.total }
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["cart_items", "order", "products"]
  end
end
