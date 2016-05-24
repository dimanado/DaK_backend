class VideoSerializer < ActiveModel::Serializer
  attributes :id, :name, :url, :format, :description, :image, :created_at, :like_size,
             :dislike_size, :author_id
  has_many :comments

  def url
    object.full_url
  end

  def image
    object.image.full_url(:course_sketch)
  end

  def dislike_size
    Vote.get_dislikes(object.class.to_s.downcase, object.id).size
  end

  def like_size
    Vote.get_likes(object.class.to_s.downcase, object.id).size
  end

  def author_id
    object.course.user_id
  end

end