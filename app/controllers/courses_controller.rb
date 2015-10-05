class CoursesController < ApplicationController
  before_action :authenticate_user!

  def index
    @courses=current_user.courses
  end

  def create
    if course=Course.create(params.permit(:name))
      current_user.courses<<course
      render_blank_success
    else
      render json: {error: 'Course not create'}, status: 400
    end
  end
end
