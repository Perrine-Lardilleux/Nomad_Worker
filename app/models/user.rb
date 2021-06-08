class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reviews
  has_many :wishlists, dependent: :destroy

  def wishlists?(city)
    city.wishlists.where(user_id: id).any?
  end
end
