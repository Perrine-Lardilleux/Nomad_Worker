class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reviews
  has_many :wishlists, dependent: :destroy
  has_one_attached :photo

  def wishlists?(city)
    city.wishlists.where(user_id: id).any?
  end

  def profile_picture
    photo.attached? ? photo : 'digital-nomad.png'
  end
end
