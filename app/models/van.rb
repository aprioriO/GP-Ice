class Van < ApplicationRecord
  belongs_to :user
  has_many :orders
  has_many :favourites
  has_many :favourited_users, through: :favourites, source: :user
  has_many :inventories
  has_many :products, through: :inventories


  validates :name, presence: true, uniqueness: true
  validates :location, presence: true
end
