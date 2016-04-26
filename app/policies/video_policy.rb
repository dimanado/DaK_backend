class VideoPolicy < ApplicationPolicy
  def create?
    user.has_role? :lecturer
  end
end