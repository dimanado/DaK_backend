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
    course_form = CourseForm.new(params)
    if course_form.save(current_user.id)
      render_success
    else
      render_error_messages(course, 400)
    end
  end
end
