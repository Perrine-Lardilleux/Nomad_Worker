class City < ApplicationRecord
  belongs_to :country
  has_many :reviews, dependent: :destroy
  has_many :wishlists
  validates :name, presence: true
end
