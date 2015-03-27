class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def show
    @review = Review.find params[:id]
  end

  def create
    @review = Review.new review_params
    @review.user = current_user
    if @review.save
      @review.book.update_attributes rating: @review.book.calculate_rating.round(2)
      respond_to do |format|
        format.html
        format.js {@book = @review.book}
      end  
    else
      flash[:danger] = "not created review"
      redirect_to @review.book
    end
  end  

  def edit
    @review = Review.find params[:id]
  end

  def update
    @review = Review.find params[:id]
    if @review.update_attributes review_params
      @review.book.update_attributes rating: @review.book.calculate_rating.round(2)
      respond_to do |format|
        format.html {redirect_to @review.book}
        format.js {@book = @review.book}
      end
    else
      flash[:danger] = "Review is not updated"
      redirect_to @review.book
    end    
  end

  def destroy
    review = Review.find params[:id]
    review.destroy
    review.book.update_attributes rating: review.book.calculate_rating.round(2)
    flash[:success] = "Review is deleted"
    redirect_to review.book
  end  

  private
  def review_params
    params.require(:review).permit :content, :book_id, :rate
  end  
end
