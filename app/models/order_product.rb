class OrderProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :product_id, :order_id, presence: true
  validates :quantity_ordered, presence: true, numericality: { greater_than: 0 }
end
