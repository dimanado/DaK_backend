class UsersSerializer < ActiveModel::Serializer
  attributes :id, :email, :role
  def role
    object.roles.first.name
  end
end
