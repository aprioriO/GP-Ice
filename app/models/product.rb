class Product < ApplicationRecord
  has_many :inventories
  has_many :order_products

  validates :name, :description, :photo, presence: true
end
