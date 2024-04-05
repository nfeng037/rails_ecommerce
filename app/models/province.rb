class Province < ApplicationRecord
  has_many :address
  has_many :orders
end
