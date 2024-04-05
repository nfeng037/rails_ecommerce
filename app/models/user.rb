class User < ApplicationRecord
  has_many :orders
  has_many :addresses
  has_one :cart
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, unless: -> { guest? }
  validates :password, presence: true, length: { minimum: 6 }, unless: -> { guest? }

end
