class CourseSerializer < ActiveModel::Serializer
  attributes :id, :name, :image
  def image
    object.image.full_url(:course_sketch)
  end

end
