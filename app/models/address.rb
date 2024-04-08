class Address < ApplicationRecord
  belongs_to :user
  belongs_to :province

  def full_address
    "#{name}, #{phone_number}, #{address_line}, #{city}, #{province.name}, #{postal_code}"
  end

  validates :name, :phone_number, :address_line, :city, :postal_code, :province_id, presence: true
end
