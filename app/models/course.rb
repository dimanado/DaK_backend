class Course < ActiveRecord::Base
  belongs_to :user
  has_many :videos, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_and_belongs_to_many :subscriptions
  has_and_belongs_to_many :categories
  accepts_nested_attributes_for :categories, allow_destroy: true
  has_one :image, dependent: :destroy
  validates_uniqueness_of :name

  def video_meta
    { name: name, description: description, course_id: id,
      image: image.full_url(:course_sketch), user_id: user_id,
      tasks: tasks, domain: Settings.domain_name }
  end


end