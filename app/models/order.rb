class Order < ApplicationRecord
  belongs_to :user
  belongs_to :van

  has_many :reviews
  has_many :order_products
  has_many :products, through: :order_products

  validates :confirmed_status, :paid_status, inclusion: { in: [true, false] }
end
