class User < ApplicationRecord
  has_many :oders
  has_many :addresses
  belongs_to :province
  has_one :cart
end
