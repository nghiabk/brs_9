class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.paginate page: params[:page]
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
end
