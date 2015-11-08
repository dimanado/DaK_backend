class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    render json: current_user, serializer: UsersSerializer
  end

  def update
    #file_arr = params.values.find_all { |value| value.class == ActionDispatch::Http::UploadedFile }
    if current_user.update_attributes(user_params)
      # unless file_arr.empty?
      #   file_arr.each { |attach|
      #     @attach = Attach.new
      #     @attach.filename = attach
      #     @attach.attachable = current_user
      #     @attach.save
      #   }
      # end
      render_success
    else
      render_error_messages(current_user, 400)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :nickname, :email)
  end

end
