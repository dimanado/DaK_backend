class VoteVideoSerializer < ActiveModel::Serializer
  attributes  :id, :like_size, :dislike_size, :description, :name
  has_many :comments

  def dislike_size
    Vote.get_dislikes(object.class.to_s.downcase, object.id).size
  end

  def like_size
    Vote.get_likes(object.class.to_s.downcase, object.id).size
  end
end