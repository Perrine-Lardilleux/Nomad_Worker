class WishlistsController < ApplicationController
  def index
    skip_policy_scope
    @wishlists = Wishlist.all
  end

  def create
    @wishlist = Wishlist.new(user: current_user, city: params[:city_id])
    authorize(@wishlist)
    if @wishlist.save
      continue
    else
      raise
    end
  end

  def destroy
    @wishlist = Wishlist.find(params[:id])
    authorize(@wishlist)
    @wishlist.destroy
  end
end
