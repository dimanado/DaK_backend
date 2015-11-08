class User < ActiveRecord::Base
  #user, admin, lecturer
  rolify
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User
  has_many :attaches, as: :attachable, dependent: :destroy
  has_many :courses
  belongs_to :role

  before_create :default_users_role

  private

  def default_users_role
    add_role :user
  end

end
