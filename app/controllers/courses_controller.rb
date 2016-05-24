class CoursesController < ApplicationController
  before_action :authenticate_user!, except: [ :index ]
  before_action :set_course, only: [:destroy]


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
    @course.delete ? render json: {id: params[:id]}.to_json :
      render_error_messages(@course, 400)
  end

  def create
    authorize :courses
    course_form = CourseForm.new(params)
    if course_form.save(current_user.id)
      render_success
    else
      render_error_messages(course, 400)
    end
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end
end
