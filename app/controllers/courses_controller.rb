class CoursesController < ApplicationController
  before_action :authenticate_user!, except: [ :index ]

  def index
    if params[:all]
      #TODO: mode params[:all] to scope policies
      @courses = Course.all
    else
      authorize :courses
      @courses = policy_scope(:Courses)
    end
    render json: @courses, each_serializer: CourseSerializer
  end

  def show
  end

  def destroy
    course = Course.find(params[:id])
    if course.delete
      render json: {id: params[:id]}.to_json
    else
      render_error_messages(course, 400)
    end
  end

  def create
    authorize :courses
    course = current_user.courses.new(course_params)
    course.build_image(file: image_params)
    course.category_ids = categories_params
    course.tasks = Task.parsing_to_array(tasks_params) if params[:tasks]
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

  def tasks_params
    params[:tasks].values
  end

  def categories_params
    params[:category_ids].values
  end

end
