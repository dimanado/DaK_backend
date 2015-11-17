class VideoController < ApplicationController
  before_action :set_course, only: [:index, :create]
  before_action :set_video, only: [:show]
  before_action :authenticate_user!, except: [ :index ]

  def index
    @videos = @course.videos
    render json: @videos, each_serializer: VideoNameSerializer
  end

  def create
    video = @course.videos.new(video_params)
    image = Image.new(file: image_params)
    if !image.save
      render_error_messages(image, 400)
    elsif video.save
      video.image = image
      render_success
    else
      render_error_messages(video, 400)
    end
  end

  def show
    render json: @video, serializer: VideoSerializer
  end



  private

  def video_params
    { video: params[:file].tempfile, format: params[:file].content_type,
      name: params[:name], description: params[:description]}
  end

  def image_params
    params[:image].tempfile
  end

  def set_course
    @course = Course.find(params[:id_course])
  end

  def set_video
    @video = Video.find(params[:id])
  end
end
