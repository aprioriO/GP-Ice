class OrderProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :quantity_ordered, presence: true, numericality: { greater_than: 0 }
end
