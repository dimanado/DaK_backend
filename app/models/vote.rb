class Vote < ActiveRecord::Base
  belongs_to :votable, polymorphic: true
  belongs_to :user

  def self.get_dislikes(type, id)
    Vote.where(vote_flag: false, votable_type: type, votable_id: id)
  end

  def self.get_likes(type, id)
    Vote.where(vote_flag: true, votable_type: type, votable_id: id)
  end
end

