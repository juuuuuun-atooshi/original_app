class EventsController < ApplicationController
  before_action :set_event, only:[:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :searchinfo, :search]


  def index
    @events = Event.all
  end

  def show
  end

  def new
    if params[:back]
      @event = Event.new(events_params)
    else
      @event = Event.new
    end
  end

  def create
    @event = Event.create(events_params)
    @event.organizer_id = current_user.id
    if @event.save
      redirect_to events_path, notice: 'イベントを投稿しました！'
    else
      render 'new'
    end
  end

  def edit
  end

  def update

    unless params[:action_name].blank?
      if params[:action_name] == 'participation'
        participation
      end
    else

      if @event.update(events_params)
        redirect_to events_path, notice: 'イベント内容を変更しました！'
      else
        render 'new'
      end
    end

  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: 'イベントを削除しました！'
  end

  def confirm
    @event = Event.new(events_params)
    render :new if @event.invalid?
  end

  def participation
    redirect_to participation_participants_path(params[:id])
  end

  def searchinfo
    if params[:link_name] == 'event'
      @search_event = Search::Event.new
    else
      @search_artist = Search::Artist.new
    end
  end

  def search
    respond_to do |format|
      if params[:search_artist].blank?
        @events = Search::Event.new(search_event_params)
        @events = @events.matches.order(date: :asc)
      else
        @artist = Search::Artist.new(search_artist_params)
        @artists = @artist.matches
        @test = Artist.find_by(user_id: current_user.id)
      end

      format.html { redirect_to searchinfo_events_path }
      format.js { render :searchinfo }
    end

  end

  private
    def events_params
      params.require(:event).permit(:title, :date, :content, :image, :image_cache)
    end

    def search_event_params
      params.require(:search_event).permit(Search::Event::ATTRIBUTES)
    end

    def search_artist_params
      params.require(:search_artist).permit(Search::Artist::ATTRIBUTES)
    end

    def set_event
      @event = Event.find(params[:id])
    end
end
