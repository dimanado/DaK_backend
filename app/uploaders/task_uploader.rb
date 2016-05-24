class TaskUploader < CarrierWave::Uploader::Base
  storage :file

  def pre_limit(file)
    if file && file.size > 5.megabytes
      raise RangeError.new("too large")
    end
    true
  end

  def extension_white_list
    %w(pdf doc docx)
  end
end

