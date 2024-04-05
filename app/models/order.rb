class Order < ApplicationRecord
  belongs_to :user
  belongs_to :province
  belongs_to :cart
end
