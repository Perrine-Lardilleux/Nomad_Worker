class WishlistsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_city, only: [:create, :create_index]

  def index
    skip_policy_scope
  end

  def create
    @wishlist = Wishlist.where(user: current_user, city: @city).first_or_create
    authorize(@wishlist)
    if @wishlist.save
      redirect_to request.referrer # prestar atenção Lucas
    else
      raise # Temp REMOVE LATER
    end
  end

  def create_index
    @wishlist = Wishlist.where(user: current_user, city: @city).first_or_create
    authorize(@wishlist)
    if @wishlist.save
      redirect_to root_path(@city, anchor: "city-#{@city.id}") #prestar atenção Lucas
    else
      raise # Temp REMOVE LATER
    end
  end


  def destroy
    # raise
    @wishlist = Wishlist.where(city_id: params[:id], user: current_user)
    authorize(@wishlist)
    @wishlist.destroy_all
    redirect_to request.referrer # prestar atenção Lucas
  end

  private

  def set_city
    @city = City.find(params[:city_id])
  end

end
