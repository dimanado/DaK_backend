class Video < ActiveRecord::Base
  belongs_to :course

  mount_uploader :video, VideoUploader

  validates_uniqueness_of :name

end
