class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.paginate page: params[:page]
  end
  
  def show
    @book_states = current_user.book_states
    @user = User.find params[:id]
    if !params[:type].blank? && ['following','followers'].include?(params[:type])
      @title = params[:type]
      @users = @user.send params[:type]
      @users = @users.paginate page: params[:page]
      render 'show_follow'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
end