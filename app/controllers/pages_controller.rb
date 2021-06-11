class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @cities = City.all

    @markers = @cities.map do |city|
      {
        lat: city.latitude,
        lng: city.longitude,
        info_window: render_to_string(partial: "cities/info_window", locals: { city: city })
      }
    end
  end

  def my_profile
  end

  def economical
    @city = City.find(params[:city_id])
    @data = @city.data
  end

  def expensive
    @city = City.find(params[:city_id])
    @data = @city.data
  end
end
