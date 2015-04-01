class BooksController < ApplicationController
  def index
    @books = if params[:sort] == "favorite"
      current_user.load_favorites
    else
      Book.includes(:category).search(params[:search], 
            params[:filter]).order sort_column
    end  
    @books = @books.paginate page: params[:page], per_page: 10
  end

  def show
    @book = Book.find params[:id]
  end

  private
  def sort_column
    params[:sort] ? params[:sort] : "title"
  end  
end