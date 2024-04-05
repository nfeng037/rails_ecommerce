class Order < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :province
  belongs_to :cart
end
