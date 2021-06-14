class CitiesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params[:query].present?
      sql_query = " \
        cities.name @@ :query \
        OR countries.name @@ :query \
      "
      @cities = policy_scope(City).joins(:country).where(sql_query, query: "%#{params[:query]}%")
    else
      @cities = policy_scope(City)
    end
  end

  def show
    @city = City.find(params[:id])
    @review = Review.new # So we can render the review form here
    authorize(@city)
    respond_to do |format|
      format.html
      format.json { render json: @city }
    end
  end

  def send_details
    @city = City.find(params[:city_id])
    CityMailer.city_details(current_user, @city).deliver_now
    authorize(@city)
  end
end
