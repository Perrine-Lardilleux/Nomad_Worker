class CitiesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @cities = policy_scope(City)

    @markers = @cities.map do |city|
      {
        lat: city.coordinates.split[0].to_i,
        lng: city.coordinates.split[1].to_i
      }
    end
    # @markers = [{lat: -23.5507, lng: -46.6334 }]
  end

  def show
    @city = City.find(params[:id])
    @review = Review.new # So we can render the review form here
    authorize(@city)
  end
end
