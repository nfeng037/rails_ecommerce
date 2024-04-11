class Payment < ApplicationRecord
  belongs_to :order

  enum status: { processing: 0, successful: 1, failed: 2 }

  def self.ransackable_attributes(auth_object = nil)
    ["amount", "created_at", "id", "id_value", "order_id", "payment_date", "status", "updated_at"]
  end
end
