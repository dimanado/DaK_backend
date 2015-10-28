class CoursesController < ApplicationController
  before_action :authenticate_user!, except:[:index]

  def index
    if params[:all]
      @courses=Course.all
    else
      @courses=current_user.courses
    end
    render json: @courses, each_serializer: CourseSerializer
  end

  def create
    authorize :courses, :create?
    course = current_user.courses.new(course_params)
    if course.save
      render_success
    else
      render_error_messages(course, 400)
    end
  end

  private

  def course_params
    params.permit(:name)
  end

end
