class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :root_comments, class: "Comment", foreign_key: "root_comment_id"

  def get_root_comment_nickname(id)
    Comment.find(id).user.nickname
  end
end
