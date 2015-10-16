class VideoController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course, only: [:index, :create]
  before_action :set_video, only: [:show]

  def index
    @videos = @course.videos
    render json: @videos, each_serializer: VideoNameSerializer
  end

  def create
    # binding.pry
    video = @course.videos.new(video_params)
    if video.save
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
    { video: params[:file].tempfile, format: params[:file].content_type, name:params[:name] }
  end

  def set_course
    @course = Course.find(params[:id_course])
  end

  def set_video
    @video = Video.find(params[:id])
  end
end
