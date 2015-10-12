class VideoController < ApplicationController
  before_action :authenticate_user!

  def index
    @videos=Course.find(params[:id_course]).videos
    render json: @videos, each_serializer: VideoNameSerializer
  end

  def create
    video=Course.find(params[:id_course]).videos.new(video: params[:file].tempfile,
                                                     format: params[:file].content_type,
                                                     name:params[:name])
    if video.save
      render_success
    else
      render json: {error: 'Video not create'}, status: 400
    end
  end

  def show
    @video=Video.find(params[:id])
    render json: @video, serializer: VideoSerializer
  end
end
