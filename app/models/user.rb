class User < ActiveRecord::Base
  #user, admin, lecturer
  rolify
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User
  has_many :votes
  has_many :courses
  has_many :tasks, through: :courses
  has_many :comments
  belongs_to :role
  has_one :subscription
  has_and_belongs_to_many :tasks

  acts_as_messageable

  before_create :default_users_role, :add_subscription


  def vote_init(vote_type, item_id, item_type)
    case vote_type
      when 'like'
        like = voted_up_on(item_id,item_type)
        like ? like.delete : like(item_type,item_id)
      when 'dislike'
        dislike = voted_down_on(item_id,item_type)
        dislike ? dislike.delete : dislike(item_type,item_id)
    end
  end

  def voted_up_on(item_id, item_type)
    Vote.find_by(user_id: self.id, votable_id: item_id,
            votable_type: item_type.downcase, vote_flag: true)
  end

  def voted_down_on(item_id, item_type)
    Vote.find_by(user_id: self.id, votable_id: item_id,
            votable_type: item_type.downcase, vote_flag: false)
  end

  def like(type,id)
    vote = Vote.create(votable_id: id, votable_type: type.downcase, vote_flag: true)
    self.votes << vote
  end

  def dislike(type,id)
    vote = Vote.create(votable_id: id, votable_type: type.downcase, vote_flag: false)
    self.votes << vote
  end

  def default_users_role
    add_role :user
  end

  def add_subscription
    self.subscription = Subscription.create!
  end

  def mailboxer_email(object)
    email
  end

end
