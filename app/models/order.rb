class Order < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :province
  belongs_to :cart
  has_many :payments

  validates :name, :phone_number, :address, :city, :postal_code, :province_id, presence: true, unless: :user_id?

  enum status: { pending: 0, paid: 1, cancelled: 2, failed: 3 }

  def self.ransackable_attributes(auth_object = nil)
    ["address", "cart_id", "city", "created_at", "id", "id_value", "is_guest", "name", "payment_intent_id", "phone_number", "postal_code", "province_id", "status", "taxes", "total_with_taxes", "updated_at", "user_id"]
  end
end
