class WishlistsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_city, only: %i[create destroy destroy_wishlist]

  def index
    skip_policy_scope
  end

  def create
    @wishlist = Wishlist.where(user: current_user, city: @city).first_or_create
    authorize(@wishlist)
    raise unless @wishlist.save

    respond_to do |format|
      format.js
      format.html { redirect_to @city }
    end
  end

  def destroy
    @wishlist = Wishlist.where(city: @city, user: current_user)
    authorize(@wishlist)
    @wishlist.destroy_all
    respond_to do |format|
      format.js
      format.html { redirect_to root }
    end
  end

  def destroy_wishlist
    @wishlist = Wishlist.where(city: @city, user: current_user)
    authorize(@wishlist)
    @wishlist.destroy_all
    redirect_to wishlists_path
  end

  private

  def set_city
    @city = City.find(params[:city_id])
  end
end
