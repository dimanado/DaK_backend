# encoding: utf-8

class VideoUploader < CarrierWave::Uploader::Base
  storage :file
end

