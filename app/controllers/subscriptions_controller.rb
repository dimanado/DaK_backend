class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def add_course
    unless current_user.subscription.courses.find_by(id: course_id)
      current_user.subscription.courses << Course.find_by(id: course_id)
      render_success
    else
      render json: {error: 'course has already been created'}, status: 400
    end
  end

  def check_status
    if current_user.subscription.courses.find(course_id)
      render_success
    end
  end

  private

  def course_id
    params.require(:id)
  end
end