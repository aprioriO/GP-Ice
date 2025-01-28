class Order < ApplicationRecord
  belongs_to :user
  belongs_to :van

  has_one :review
  has_many :order_products
  has_many :products, through: :order_products


  validates :user_id, :van_id, presence: true
  validates :confirmed_status, :paid_status, inclusion: { in: [true, false] }
end
