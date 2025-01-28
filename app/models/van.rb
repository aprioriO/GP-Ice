class Van < ApplicationRecord
  belongs_to :user
  has_many :orders
  has_many :favourites
  has_many :inventories

  validates :name, :location, presence: true
end
