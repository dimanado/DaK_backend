class Image < ActiveRecord::Base

  mount_uploader :file, PhotoUploader


  def full_url(format)
    Settings.domain_name + file.url(format.to_sym)
  end
end