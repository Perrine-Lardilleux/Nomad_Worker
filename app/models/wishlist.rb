class Wishlist < ApplicationRecord
  belongs_to :city
  belongs_to :user
  validates :city, uniqueness: { scope: :user, message: "Wishlists must be unique for city/user scope" }
end
