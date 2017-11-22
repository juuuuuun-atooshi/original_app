class ConversationsController < ApplicationController
  def index
    @users = User.all
    @conversations = Conversatin.all
  end

  def create
  end

end
