class Address < ApplicationRecord
  belongs_to :user
  belongs_to :province

  def full_address
    "#{name}, #{phone_number}, #{address_line}, #{city}, #{province.name}, #{postal_code}"
  end

  validates :name, :phone_number, :address_line, :city, :postal_code, :province_id, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["address_line", "city", "created_at", "id", "id_value", "name", "phone_number", "postal_code", "province_id", "updated_at", "user_id"]
  end
end
