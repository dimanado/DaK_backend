class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    render json: current_user, serializer: UsersSerializer
  end

  def get_id
    user = User.find_by(nickname: params[:nickname])
    render json: {id: user.id}.to_json
  end

  def update
    user = User.find(params[:id])
    user.update_attributes(nickname: params[:nickname], email: params[:email])
    render json: user, serializer: UsersSerializer
  end

  def vote
    @item = params[:item_type].capitalize.constantize.find(params[:id])
    current_user = User.find_by(email: params[:user_email])
    current_user.vote_init(params[:vote_type], params[:id], params[:item_type])
    render json: @item, serializer: VoteVideoSerializer
  end

end