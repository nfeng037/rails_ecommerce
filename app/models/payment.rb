class Payment < ApplicationRecord
  belongs_to :order

  enum status: { processing: 0, successful: 1, failed: 2 }
end
