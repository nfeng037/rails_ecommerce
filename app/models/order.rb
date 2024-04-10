class Order < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :province
  belongs_to :cart
  has_many :payments

  validates :name, :phone_number, :address, :city, :postal_code, :province_id, presence: true, unless: :user_id?

  enum status: { pending: 0, paid: 1, cancelled: 2, failed: 3 }

end
