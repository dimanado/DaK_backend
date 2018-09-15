class SessionsController < ApplicationController
  def new
  end

  def create
    user = Admin.find_by(email: params[:session][:email])
    if user && user.test_password(params[:session][:password], user.password)
      session.clear
      session[:user_id] = user.id
      redirect_to admin_url
    else
      flash[:alert] = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url
  end
end