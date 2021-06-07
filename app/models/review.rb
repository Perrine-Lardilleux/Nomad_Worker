class Review < ApplicationRecord
  belongs_to :city
  belongs_to :user
  validates :content, presence: true, length: { minimum: 20 }
end
