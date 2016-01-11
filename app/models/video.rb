class Video < ActiveRecord::Base
  belongs_to :course
  has_one :image, dependent: :destroy
  
  mount_uploader :video, VideoUploader

  validates_uniqueness_of :name

  def full_url
    Settings.domain_name + video.url
  end
end
