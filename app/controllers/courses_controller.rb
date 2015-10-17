class CoursesController < ApplicationController
  before_action :authenticate_user!, except:[:all_courses]

  def index
    @courses=current_user.courses
    render json: @courses, each_serializer: CourseSerializer
  end

  def create
    course = current_user.courses.new(course_params)
    if course.save
      render_success
    else
      render_error_messages(course, 400)
    end
  end

  def all_courses
    @courses=Course.all
    render json: @courses, each_serializer: CourseSerializer
  end

  private

  def course_params
    params.permit(:name)
  end

end
