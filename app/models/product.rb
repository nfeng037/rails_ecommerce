class Product < ApplicationRecord
  belongs_to :category
  def self.ransackable_attributes(auth_object = nil)
    ["active", "category_id", "created_at", "description", "id", "id_value", "name", "price", "stock", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end

  has_one_attached :image

  has_many :cartItems
  has_many :carts, through: :cartItems
  has_many :order_items

  validates :name, :price, :stock, :category_id, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.0 }
  validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
