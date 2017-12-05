class ReversenominationsController < ApplicationController
  def index
  end

  def new
    @organizer = Organizer.find_by(user_id: current_user.id)
    @artist = Artist.find_by(user_id: params[:artist_id])

    @reversenomination = Reversenomination.new
  end

  def create
  end

  def show
  end

  def confirm
    binding.pry
  end

  private
    def reversenomination_params
      params.require(:reversenomination).permit(:artist_id, :event_id, :privilege)
    end

end
