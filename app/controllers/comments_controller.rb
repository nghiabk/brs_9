class CommentsController < ApplicationController
  respond_to :js
  
  def index
    @review = Review.find params[:review_id]
  end

  def create
    @comment = Comment.new comment_params
    @comment.user = current_user      
    if @comment.save
      create_activity @comment.id, "comment"
    else
      redirect_to @comment.book  
    end    
  end

  def destroy
    @comment = Comment.find params[:id]
    @comment.destroy
  end

  private
  def comment_params
    params.require(:comment).permit :content, :book_id, :review_id
  end  
end
