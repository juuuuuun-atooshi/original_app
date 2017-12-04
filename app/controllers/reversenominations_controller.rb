class ReversenominationsController < ApplicationController
  def index
  end

  def new
    @events = Event.ransack(params[:q])
    @artists = Artist.ransack(params[:q])
    if params[:back]
      @reversenomination = Reversenomination.new(reversenomination_params)
    elsif params[:direct]
      @reversenomination = Reversenomination.new
      @artist = Artist.find(params[:id])
    else
      @reversenomination = Reversenomination.new
    end
  end

  def search
    respond_to do |format|
      if params[:id] == 'event'
        @q = Event.ransack(params[:q])
        @results = @q.result
      else
        @q = Artist.ransack(params[:q])
        @results = @q.result
      end

      format.html { redirect_to searchinfo_events_path }
      format.js { render :searchinfo }
    end

  end

  def create
  end

  def show
  end

  def confirm
  end

  private
    def reversenomination_params
      params.require(:reversenomination).permit(:artist_id, :event_id, :privilege)
    end

end
