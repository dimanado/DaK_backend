class Course < ActiveRecord::Base
  belongs_to :user
  has_many :videos, dependent: :destroy
  has_and_belongs_to_many :subscriptions
  has_one :image, dependent: :destroy
  validates_uniqueness_of :name
end