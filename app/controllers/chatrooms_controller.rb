class ChatroomsController < ApplicationController
  def show
    skip_authorization
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end
end
