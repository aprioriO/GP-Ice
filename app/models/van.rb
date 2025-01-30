class Van < ApplicationRecord
  belongs_to :user
  has_many :orders
  has_many :favourites
  has_many :favourited_users, through: :favourites, source: :user
  has_many :inventories
  has_many :products, through: :inventories

  validates :name, presence: true, uniqueness: true
  validates :location, presence: true
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
  # private

  # def geocode_location
  #   if location.present?
  #     geocoded = Geocoder.search(location).first
  #     if geocoded
  #       self.latitude = geocoded.latitude
  #       self.longitude = geocoded.longitude
  #     end
  #   end
  # end
end
