class ReviewsController < ApplicationController
  def create
    @city = City.find(params[:city_id])
    @review = Review.new(review_params)
    @review.city = @city
    @review.user = current_user
    authorize(@review)
    if @review.save
      redirect_to city_path(@city)
    else
      render 'cities/show'
    end
  end

  def update
    @review = Review.find(params[:id])
    @review.update(params[:content])
  end

  def destroy
    @review = Review.find(params[:id])
    authorize(@review)
    @review.destroy
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end
end
