class Review < ApplicationRecord
  belongs_to :order

  validates :rating, :content, presence: true
end
