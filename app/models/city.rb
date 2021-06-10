class City < ApplicationRecord
  belongs_to :country
  has_many :reviews, dependent: :destroy
  has_many :wishlists
  has_many :users, through: :wishlists
  validates :name, presence: true
end
