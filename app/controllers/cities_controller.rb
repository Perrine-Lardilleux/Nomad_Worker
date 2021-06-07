class CitiesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    skip_policy_scope
    @cities = City.all
  end

  def show
    skip_authorization
    @city = City.find(params[:id])
  end
end
