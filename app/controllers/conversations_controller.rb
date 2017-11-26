class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @artists = Artist.all
    @artist = Artist.find_by(user_id: current_user.id)
    @conversations = Conversation.all
  end

  def create
    binding.pry
     if Conversation.between(params[:sender_id], params[:recipient_id]).present?
       @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
     else
       @conversation = Conversation.create!(conversation_params)
     end

     redirect_to conversation_messages_path(@conversation)
  end

  private
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end

end
