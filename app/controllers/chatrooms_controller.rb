class ChatroomsController < ApplicationController
  def show
    @chatroom = Chatroom.find_by(params[:id])
    authorize @chatroom
    @message = Message.new
  end
end
