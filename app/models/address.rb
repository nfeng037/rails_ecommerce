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

  def self.ransackable_associations(auth_object = nil)
    ["province", "user"]
  end

  validates :user_id, :province_id, :name, :phone_number, :address_line, :city, :postal_code, presence: true
  validates :phone_number, format: { with: /\A[\d\s\+\-()]+\z/ }, length: { maximum: 15 }
  validates :postal_code, format: { with: /\A[\dA-Z]+\z/i }, length: { maximum: 10 }
end
