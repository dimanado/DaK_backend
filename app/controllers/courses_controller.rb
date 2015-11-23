class CoursesController < ApplicationController
  before_action :authenticate_user!, except: [ :index ]

  def index
    if params[:all]
      #TODO: mode params[:all] to scope policies
      @courses = Course.all
    else
      @courses = policy_scope(:Courses)
    end
    render json: @courses, each_serializer: CourseSerializer
  end

  def show
  end

  def create
    authorize :courses, :create?
    course = current_user.courses.new(course_params)
    course.image.new(file: image_params)
    if course.save
      render_success
    else
      render_error_messages(course, 400)
    end
  end

  private

  def course_params
    params.permit(:name, :description)
  end

  def image_params
    params[:image].tempfile
  end

end
