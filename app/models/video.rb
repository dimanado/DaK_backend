class Video < ActiveRecord::Base
  belongs_to :course
  has_one :image, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  
  mount_uploader :video, VideoUploader

  validates_uniqueness_of :name

  def full_url
    Settings.domain_name + video.url
  end

end
