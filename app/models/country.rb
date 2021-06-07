class Country < ApplicationRecord
  has_many :cities
  has_many :reviews, through: :cities
  validates :name, :language, :currency, presence: true
end
