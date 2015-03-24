class BookStatesController < ApplicationController
  def create
    @book_state = BookState.new book_state_params
    if @book_state.save
      flash.now[:success]= "success"
      respond_to do |format|
        format.html
        format.js {@book = @book_state.book}
      end
    else
      flash[:danger] = "Create book state failed."
      redirect_to @book_state.book
    end    
  end

  def update
    @book_state = BookState.find params[:id]
    if @book_state.update_attributes book_state_params
      respond_to do |format|
        format.html
        format.js {@book = @book_state.book}
      end
    else
      flash[:danger] = "Change state book failed."
      redirect_to @book_state.book
    end    
  end

  private
  def book_state_params
    params.require(:book_state).permit :state, :book_id, :user_id
  end  
end
