class CoursesController < ApplicationController
  before_action :authenticate_user!, except:[:all_courses]

  def index
    @courses=current_user.courses
    render json: @courses, each_serializer: CourseSerializer
  end

  def create
    course = current_user.courses.new(params.permit(:name))
    if course.save
      render_success
    else
      render json: {error: 'Course not create'}, status: 400
    end
  end

  def all_courses
    @courses=Course.all
    render json: @courses, each_serializer: CourseSerializer
  end

end
