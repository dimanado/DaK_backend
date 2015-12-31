# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :course_sketch do
    process resize_to_fill: [300, 200]
  end

  version :video_sketch do
    process resize_to_fill: [300, 200]
  end
end
