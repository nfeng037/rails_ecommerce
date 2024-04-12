class Province < ApplicationRecord
  has_many :addresses
  has_many :orders

  validates :name, presence: true
  validates :gst_rate, :pst_rate, :hst_rate, numericality: true
end

