class User < ActiveRecord::Base
  #user, admin, lecturer
  rolify
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  has_many :courses
  belongs_to :role
  has_one :subscription

  before_create :default_users_role, :add_subscription

  private

  def default_users_role
    add_role :user
  end

  def add_subscription
    self.subscription = Subscription.create!
  end

end
