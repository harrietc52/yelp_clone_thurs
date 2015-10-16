class EndorsementsController < ApplicationController

  def create
    @review = Review.find(params[:review_id])
    @review.edorsements.create
    redirect_to restaurants_path
  end

end
