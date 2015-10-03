class CoursesController < ApplicationController
  before_action :authenticate_user!

  def index
    @courses=current_user.courses
    render json: {}, status: :ok
  end

  def create
    if course=Course.create(params.permit(:name))
      current_user.courses<<course
      render json: {}, status: :ok
    else
      render json: {error: 'Course not create'}, status: 400
    end
  end
end
