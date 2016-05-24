class VideoForm
  include Virtus.model

  attribute :name, String
  attribute :description, String
  attribute :image, Hash
  attribute :file, Hash

  def save(id)
    video = Video.new(video: file.tempfile, format: file.content_type, name: name, description:description)
    video.course_id = id
    video.build_image(file: image.tempfile)
    video.save
  end
end