class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_subscription_by_user, only: [:destroy]

  def add_course
    unless current_user.subscription.courses.find_by(id: course_id)
      current_user.subscription.courses << Course.find_by(id: course_id)
      render_success
    else
      render json: {error: 'course has already been created'}, status: 400
    end
  end

  def destroy
    course = @subscription.courses.find(params[:id])
    if @subscription.courses.delete(course)
      render json: {id: params[:course_id]}.to_json
    else
      render_error_messages(@subscription, 400)
    end
  end

  def check_status
    if current_user.subscription.courses.find_by(id: course_id)
      render_success
    else
      render_success(false)
    end
  end

  private

  def course_id
    params.require(:id)
  end

  def set_subscription_by_user
    @subscription = Subscription.find(current_user.id)
  end
end