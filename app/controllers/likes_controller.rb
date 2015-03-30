class LikesController < ApplicationController
  respond_to :js
  def create
    @activity = Activity.find params[:activity_id]
    @like = Like.new activity: @activity, user: current_user
    @like.save
  end 

  def destroy
    @like = Like.find params[:id]
    @like.destroy
  end  
end
