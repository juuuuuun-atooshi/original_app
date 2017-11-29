class ConcernsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_loginUser, only:[:create, :destroy]
  respond_to :js

  def create
    @artist = Artist.find(params[:concern][:followed_id])
    @loginUser = Artist.find_by(user_id: current_user.id)
    @loginUser.follow!(@artist)
    respond_with @artist
  end

  def destroy
    @artist = Concern.find(params[:id]).followed
    @loginUser.unfollow!(@artist)
    respond_with @artist
  end

  private
    def set_loginUser
      @loginUser = Artist.find_by(user_id: current_user.id)
    end
end
