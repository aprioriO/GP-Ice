class Review < ApplicationRecord
  belongs_to :order

  validates :content, presence: true, length: { minimum: 10 }
  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :order_id, presence: true
end
