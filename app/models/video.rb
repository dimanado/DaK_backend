class Video < ActiveRecord::Base
  acts_as_votable
  belongs_to :course
  has_one :image, dependent: :destroy
  
  mount_uploader :video, VideoUploader

  validates_uniqueness_of :name

  def full_url
    Settings.domain_name + video.url
  end

  def vote_init(current_user,type)
    case type
      when 'like'
        if current_user.voted_for? self
          if current_user.voted_up_on? self
            self.downvote_by current_user
          else
            self.upvote_by current_user
          end
        else
          self.upvote_by current_user
        end
      when 'dislike'
        if current_user.voted_for? self
          if current_user.voted_down_on? self
            self.upvote_by current_user
          else
            self.downvote_by current_user
          end
        else
          self.downvote_by current_user
        end
    end
  end
end
