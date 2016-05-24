class CommentsController < ApplicationController
  before_action :set_video, except: [ :destroy ]
  before_action :authenticate_user!

  def index
    render json: @video.comments
  end

  def create
    comment = @video.comments.new(comment_params)
    if comment.save
      render json: comment
    else
      render_error_messages(comment, 400)
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.delete
      render json: comment
    else
      render_error_messages(comment, 400)
    end
  end


  private

  def comment_params
    {
        body: params[:body],
        commentable_id: params[:item_id],
        commentable_type: params[:type],
        user_id: params[:sender_id],
        root_comment_id: params[:root_comment_id]
    }
  end

  def set_video
    @video = Video.find(params[:item_id])
  end

end
