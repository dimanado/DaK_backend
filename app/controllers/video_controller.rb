class VideoController < ApplicationController
  def create
    video=Course.find(params[:id_course]).videos.new(video: params[:file].tempfile)
    if video.save
      render_success
    else
      render json: {error: 'Video not create'}, status: 400
    end

  end
end
