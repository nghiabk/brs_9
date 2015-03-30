class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) {|u| u.permit(:email, :username)}
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, 
      :username, :image, :password, :password_confirmation)}
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit( :image, 
      :password, :password_confirmation, :current_password)}
  end

  def admin_user
    redirect_to root_url  unless current_user.is_admin?  
  end

  def create_activity target_id, action
    Activity.create user: current_user, target_id: target_id, action_type: action
  end  
end