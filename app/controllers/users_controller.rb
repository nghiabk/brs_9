class UsersController < ApplicationController
  def index
    @users = User.paginate page: params[:page]
  end
  
  def show
    @user = User.find params[:id]
    if !params[:type].blank? && ['following','followers'].include?(params[:type])
      @title = params[:type]
      @users = @user.send params[:type]
      @users = @users.paginate page: params[:page]
      render 'show_follow'
    else
      respond_to do |format|
        format.html
        format.js
      end  
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
end