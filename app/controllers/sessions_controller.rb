class SessionsController < ApplicationController

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user && user.authenticate(params[:session][:password])
      flash[:success] = t ".success"
      log_in user
      redirect_to user
    else
      flash.now[:danger] = t ".login_error"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
