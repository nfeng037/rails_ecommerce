class Order < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :province
  has_many :payments
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates :name, :phone_number, :address, :city, :postal_code, :province_id, presence: true, unless: :user_id?

  enum status: { pending: 0, paid: 1, cancelled: 2, failed: 3 }

  def self.ransackable_attributes(auth_object = nil)
    ["address", "city", "created_at", "id", "id_value", "is_guest", "name", "payment_intent_id", "phone_number", "postal_code", "province_id", "status", "taxes", "total_with_taxes", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["order_items", "payments", "products", "province", "user"]
  end

  validates :name, :address, :city, :postal_code, :province_id, presence: true
  validates :phone_number, presence: true, format: { with: /\A[\d\s\+\-()]+\z/ }, length: { maximum: 15 }
  validates :total_with_taxes, :taxes, numericality: true
end
