class Product < ApplicationRecord
  has_many :inventories
  has_many :vans, through: :inventories
  has_many :order_products
  has_many :orders, through: :order_products

  validates :name, presence: true, uniqueness: true
  validates :description, :photo, presence: true
end
