class User < ApplicationRecord
  has_many :orders
  has_one :address
  accepts_nested_attributes_for :address
  has_one :cart
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 6 }, if: -> { password.present? || new_record? }

  def self.ransackable_associations(auth_object = nil)
    ["address", "cart", "orders"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "encrypted_password", "id", "id_value", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end

end
