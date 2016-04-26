class CoursesPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.has_role? :lecturer
        user.courses
      else
        user.subscription.courses
      end
    end
  end
  def create?
    user.has_role? :lecturer
  end

  def index?
    user.present?
  end
end