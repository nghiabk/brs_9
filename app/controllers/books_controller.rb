class BooksController < ApplicationController
  before_action :get_categories, only: [:new, :edit]

  def new
    @book = Book.new
  end
  
  def create
    @book = Book.new book_params
    if @book.save
      respond_to do |format|
        format.html {redirect_to root_url, notice: "Book is created"}
        format.js
      end
    else
      render 'new'
    end
  end

  def edit
    @book = Book.find params[:id]
  end

  def update
    @book = Book.find params[:id]
    if @book.update_attributes book_params
      flash[:success] = "updated book!"
      redirect_to @book
    else
      flash.now[:danger] = "Not success!"
      render "edit"
    end
  end

  def show
    @book = Book.find params[:id]
  end

  private

  def book_params
    params.require(:book).permit :title, :author, :publish_date, :number_page,
      :image, :category_id
  end

  def get_categories
    @categories = Category.order(:name).map{|category| [category.name, category.id]}
  end  
end