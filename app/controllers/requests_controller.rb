class RequestsController < ApplicationController
  before_action :verify_admin

  def index
    @requests = current_user.requests
    @requests = @requests.paginate page: params[:page], per_page: 15
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
  def verify_admin
    if current_user.is_admin?
      flash[:success] = "Admin can't create request"
      redirect_to root_url
    end
  end

  def request_params
    params.require(:request).permit :book_name, :book_url
  end   
end