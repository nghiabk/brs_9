class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @books = Book.all.paginate page: params[:page]
  end

  def show
    @book = Book.find params[:id]
  end
end