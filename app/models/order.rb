class Order < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :province
  belongs_to :cart

  validates :name, :phone_number, :address, :city, :postal_code, :province_id, presence: true, unless: :user_id?
end
