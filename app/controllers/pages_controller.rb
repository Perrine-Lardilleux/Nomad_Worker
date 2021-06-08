class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    skip_authorization
  end

  def economical
    skip_authorization
    @city = City.find(params[:city_id])
    @data = @city.data
  end

  def expensive
    skip_authorization
    @city = City.find(params[:city_id])
    @data = @city.data
  end
end
