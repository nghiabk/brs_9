class CategoriesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @categories = Category.paginate page: params[:page]
    @category = Category.new
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = "Created success"
      redirect_to categories_url
    else
      render 'new'
    end
  end

  def edit
    @category = Category.find params[:id]
  end

  def update
    @category = Category.find params[:id]
    if @category.update_attributes category_params
      flash[:success] = "Category updated"
      redirect_to categories_url
    else
      render 'edit'
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    flash[:success] = "Category Deleted"
    redirect_to categories_url
  end

  private
  def category_params
    params.require(:category).permit :name, :image
  end
end