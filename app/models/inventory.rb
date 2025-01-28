class Inventory < ApplicationRecord
  belongs_to :product
  belongs_to :van

  validates :quantity_avaliable, :price, presence: true, numericality: { greater_than: 0 }
end
