class CoursesPolicy < ApplicationPolicy
  class Scope < Scope
    # def resolve
    #   if user.nil?
    #     scope.all
    #   else
    #     user.courses
    #   end
    # end
  end
  def create?
    user.has_role? :lecturer
  end
end