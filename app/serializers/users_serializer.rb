class UsersSerializer < ActiveModel::Serializer
  has_many :attaches
  attributes :id, :email, :role, :name, :nickname
  def role
    object.roles.first.name
  end
end
