class ReviewsController < ApplicationController
  def create
    @review = Review.new(user: current_user, city: params[:city_id], content: params[:content]) # Content has to be sent
    authorize(@review)
    if @review.save
      continue
    else
      raise
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
end
