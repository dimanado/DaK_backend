class VideoController < ApplicationController
  before_action :set_course, only: [:index, :create]
  before_action :set_video, only: [:show, :destroy]
  before_action :authenticate_user!, except: [ :index ]


  def index
    @videos = @course.videos
    render json: @videos, each_serializer: VideoNameSerializer,
           meta: @course.video_meta
  end

  def create
    authorize Video.new
    video_form = VideoForm.new(params)
    if video_form.save(@course.id)
      render_success
    else
      render_error_messages(video_form, 400)
    end
  end

  def destroy
    @video.delete ? (render json: ({id: params[:id]}.to_json)) :
        render_error_messages(@video, 400)
  end

  def show
    render json: @video, serializer: VideoSerializer
  end

  private

  def set_course
    @course = Course.find(params[:id_course])
  end

  def set_video
    @video = Video.find(params[:id])
  end

end
