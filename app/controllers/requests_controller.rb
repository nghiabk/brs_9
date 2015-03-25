class RequestsController < ApplicationController
  before_action :authenticate_user!

  def index
    @requests = current_user.requests.paginate page: params[:page], per_page: 15
  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.new request_params
    @request.user = current_user
    if @request.save
      flash[:success] = "Request is created!"
      redirect_to requests_url    
    else
      render 'new'
    end
  end

  def destroy
    Request.find(params[:id]).destroy
    flash[:success] = "Request is deleted!"
    redirect_to requests_url
  end

  private
  def request_params
    params.require(:request).permit :book_name, :book_url
  end   
end