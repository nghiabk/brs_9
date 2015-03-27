class FavoritesController < ApplicationController
  def create
    @favorite = Favorite.new favorite_params
    if @favorite.save
      respond_to do |format|
        format.html
        format.js {@book = @favorite.book}
      end
    else
      flash[:danger] = "Not add favorited"
      redirect_to @favorite.book
    end    
  end

  private
  def favorite_params
    params.require(:favorite).permit :user_id, :book_id
  end  
end
