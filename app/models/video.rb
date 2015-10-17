class Video < ActiveRecord::Base
  belongs_to :course

  mount_uploader :video, VideoUploader

end
