class HomeController < ApplicationController
  def index
    @groups = Group.all
    @channels = Array(Group.find_by(id: params[:group_id])&.channels)
    @comments = Array(Channel.find_by(id: params[:channel_id])&.comments)
  end
end
