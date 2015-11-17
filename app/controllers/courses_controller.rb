class CoursesController < ApplicationController
  before_action :authenticate_user!, except: [ :index ]

  def index
    if params[:all]
      @courses = Course.all
    else
      @courses = policy_scope(:Courses)
    end
    render json: @courses, each_serializer: CourseSerializer
  end

  def create
    authorize :courses, :create?
    course = current_user.courses.new(course_params)
    image = Image.new(file: image_params)
    if !image.save
      render_error_messages(image, 400)
    elsif course.save
      course.image = image
      render_success
    else
      render_error_messages(course, 400)
    end
  end

  private

  def course_params
    params.permit(:name)
  end

  def image_params
    params[:image].tempfile
  end

end
