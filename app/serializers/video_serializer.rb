class VideoSerializer < ActiveModel::Serializer
  attributes :id, :name, :url, :format, :description, :image
  def url
    object.full_url
  end
  def image
    object.image.full_url(:course_sketch)
  end
end