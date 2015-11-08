class UsersController < ApplicationController

  def show
    render json: current_user, serializer: UsersSerializer
  end

end