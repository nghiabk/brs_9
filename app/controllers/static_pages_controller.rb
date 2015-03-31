class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!
  
  def home
    @activities = Activity.all.order('created_at DESC').limit 30
  end
end
