class VideoNameSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :image
  def image
    object.image.full_url(:video_sketch)
  end
end