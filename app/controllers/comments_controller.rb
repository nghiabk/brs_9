class CommentsController < ApplicationController

  def index
    @review = Review.find params[:review_id]
    respond_to do |format|
      format.html
      format.js
    end  
  end

  def create
    @comment = Comment.new comment_params
    @comment.user = current_user      
    if @comment.save
      create_activity @comment.review.id, "comment"
      respond_to do |format|
        format.html
        format.js
      end
    else
      redirect_to @comment.book  
    end    
  end

  def destroy
    @comment = Comment.find params[:id]
    @comment.destroy
    respond_to do |format|
      format.html
      format.js
    end  
  end

  private
  def comment_params
    params.require(:comment).permit :content, :book_id, :review_id
  end  
end
