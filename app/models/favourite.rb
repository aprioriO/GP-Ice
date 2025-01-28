class Favourite < ApplicationRecord
  belongs_to :user
  belongs_to :van

  validates :user_id, :van_id, presence: true
end
