class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :set_user, only: [:update]
  before_action :set_user_by_nickname, only: [:get_id]

  def show
    render json: current_user, serializer: UsersSerializer
  end

  def get_id
    render json: {id: @user.id}.to_json
  end

  def update
    @user.update_attributes(nickname: params[:nickname], email: params[:email])
    render json: @user
  end

  def vote
    @item = params[:item_type].capitalize!.try(safe_constantize).try(find(params[:id]))
    current_user = User.find_by(email: params[:user_email])
    current_user.vote_init(params[:vote_type], params[:id], params[:item_type])
    render json: @item, serializer: VoteVideoSerializer
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_user_by_nickname
    @user = User.find_by(nickname: params[:nickname])
  end

  # def user_update_params
  #   params.permit(:name, :age)
  # end

end