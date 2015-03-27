class Admin::BooksController < ApplicationController

  def new
    @book = Book.new
    @book.photos.build
  end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:success] = "Book is created"
      redirect_to books_url
    else
      render 'new'
    end
  end

  def edit
    @book = Book.find params[:id]
    @book.photos.build
  end

  def update
    @book = Book.find params[:id]
    if @book.update_attributes book_params
      flash[:success] = "updated book!"
      redirect_to books_url
    else
      flash.now[:danger] = "Not success!"
      render "edit"
    end
  end

  def destroy
    Book.find(params[:id]).destroy
    flash[:success] = "Book Deleted"
    redirect_to books_url
  end

  private
  def book_params
    params.require(:book).permit :title, :author, :publish_date, :number_page,
    :category_id, photos_attributes: [:id, :image, :important]
  end
end