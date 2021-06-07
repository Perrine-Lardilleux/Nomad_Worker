class WishlistsController < ApplicationController
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
