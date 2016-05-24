class CourseSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :user_id
  has_many :categories

  def image
    object.image.full_url(:course_sketch)
  end

  def user_id
    object.user_id
  end

end
