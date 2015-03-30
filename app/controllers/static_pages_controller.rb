class StaticPagesController < ApplicationController
  def home
    @activities = Activity.all.order('created_at DESC').limit 30
  end
end
