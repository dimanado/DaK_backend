class Course < ActiveRecord::Base
  belongs_to :user
  has_many :videos
  has_and_belongs_to_many :subscriptions

  validates_uniqueness_of :name
end