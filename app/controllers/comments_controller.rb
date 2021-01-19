class CommentsController < ApplicationController
  before_action :authenticate_user!,only: [:create]
  def index
    @comments = Array(Channel.find_by(params[:channel_id])&.comments)

    render json: @comments.as_json(include: :user)
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = User.all.sample.id
    #@comment.user_id = current_user.id
    if @comment.save
      @comment.eyecatch = comment_params[:image]
      render json: @comment.as_json(include: :user)
      # render json: @comment.as_json(include: :user)←(include: user)とすることでUserの情報が全部渡っている

    end
  end

  private

  def comment_params
    params.require(:comment).permit(:channel_id, :content, :image)
  end
end
