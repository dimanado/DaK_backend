class VoteVideoSerializer < ActiveModel::Serializer
  attributes  :like_size, :dislike_size, :description, :name

  def dislike_size
    object.get_dislikes.size;
  end

  def like_size
    object.get_likes.size
  end
end