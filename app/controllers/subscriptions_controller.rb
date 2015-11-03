class SubscriptionsController < ApplicationController
  def add_course
    unless current_user.subscription.courses.where(id: course_id).take
      current_user.subscription.courses << Course.find_by(id: course_id)
    end
    render_success
  end

    private

    def course_id
      params.require(:id)
    end
end