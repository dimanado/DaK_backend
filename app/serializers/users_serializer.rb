class UsersSerializer < ActiveModel::Serializer
  attributes :id, :email
  has_many :roles
end
