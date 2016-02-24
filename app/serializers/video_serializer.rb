class VideoSerializer < ActiveModel::Serializer
  attributes :id, :name, :url, :format, :description, :image, :like_size, :dislike_size
  def url
    object.full_url
  end
  def image
    object.image.full_url(:course_sketch)
  end

  def dislike_size
    object.get_dislikes.size;
  end

  def like_size
    object.get_likes.size
  end
end