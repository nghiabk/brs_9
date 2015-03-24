class CategoriesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @categories = Category.paginate page: params[:page]
    @category = Category.new
  end
end