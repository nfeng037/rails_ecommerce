class Payment < ApplicationRecord
  belongs_to :order

  enum status: { processing: 0, successful: 1, failed: 2 }

  def self.ransackable_attributes(auth_object = nil)
    ["amount", "created_at", "id", "id_value", "order_id", "payment_date", "status", "updated_at"]
  end

  validates :order_id, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0.0 }
  validates :payment_date, presence: true
end
