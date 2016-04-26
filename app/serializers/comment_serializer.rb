class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :user_id, :root_comment_id, :created_at, :sender_nickname, :root_comment_nickname

  def sender_nickname
    object.user.nickname
  end

  def root_comment_nickname
    object.get_root_comment_nickname(object.root_comment_id) if object.root_comment_id
  end
end
