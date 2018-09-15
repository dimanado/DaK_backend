class Admin::UsersController < ApplicationController

  before_filter :authorize

  def index
    @per_page = 25
    params[:page] ? @page = params[:page] : @page = 1
    @users = User.all.order(id: :asc).paginate(page: @page, per_page: @per_page)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    redirect_to action: "index"
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end

  private
  def user_params
    params.require(:user).permit(:email, :name, :nickname)
  end

end