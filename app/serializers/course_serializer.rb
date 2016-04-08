class CourseSerializer < ActiveModel::Serializer
  attributes :id, :name, :image
  has_many :categories

  def image
    object.image.full_url(:course_sketch)
  end

end
