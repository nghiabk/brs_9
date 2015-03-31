class Admin::BaseAdminController < ApplicationController
  before_action :user_is_admin

  private
  def user_is_admin
    redirect_to root_url  unless current_user.is_admin?  
  end
end