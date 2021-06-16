class ChatroomsController < ApplicationController
  def show
    @chatroom = Chatroom.find_by(name: 'general')
    authorize @chatroom
    @message = Message.new
  end
end
