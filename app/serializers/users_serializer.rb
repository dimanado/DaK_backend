class UsersSerializer < ActiveModel::Serializer
  attributes :id, :email, :nickname
  has_many :roles
end
