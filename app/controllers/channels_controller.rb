class ChannelsController < ApplicationController
  def index
    @channels = Array(Group.find_by(id: params[:group_id])&.channels)

    render json: @channels
  end

  def create
    @channel = Channel.new(channel_params)
    if @channel.save
      render json: @channel
    end
  end
private
  def channel_params
    params.require(:channel).permit(:group_id, :name)
  end
end
