class VideoSerializer < ActiveModel::Serializer
  attributes :id, :name, :url, :format
  def url
    object.video.url
  end
end