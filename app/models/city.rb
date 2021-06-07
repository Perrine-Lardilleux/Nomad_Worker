class City < ApplicationRecord
  belongs_to :country
  has_many :reviews, dependent: :destroy
  validates :name, presence: true
end
