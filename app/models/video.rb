class Video < ActiveRecord::Base
  belongs_to :course


  mount_uploader :video, VideoUploader

  def set_success(format, opts)
    self.success = true
  end
end
