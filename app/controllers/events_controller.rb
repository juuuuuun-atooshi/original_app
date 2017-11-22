class EventsController < ApplicationController
  before_action :set_event, only:[:show, :edit, :update, :destroy]

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
      elsif params[:action_name] == 'test'
        binding.pry
        redirect_to controller: :participants, action: :create, params:{event: @event.id }
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
    binding.pry
    render 'events/participation'
  end

  private
    def events_params
      params.require(:event).permit(:title, :date, :content, :image)
    end

    def set_event
      @event = Event.find(params[:id])
    end
end
