class ReversenominationsController < ApplicationController
  def index
  end

  def new
    @organizer = Organizer.find_by(user_id: current_user.id)
    @artist = Artist.find(params[:artist_id])
    @q = Event.ransack(params[:q])

  end

  def privilege
    @reversenomination = Reversenomination.new
    if params[:back]
      @reversenomination.privilege = params[:reversenomination][:privilege]
      @artist = Artist.find(params[:reversenomination][:artist_id])
      @event = Event.find(params[:reversenomination][:event_id])
    else
      @artist = Artist.find(params[:artist_id])
      @event = Event.find(params[:event_id])
    end
  end

  def create
    @reversenomination = Reversenomination.create(reversenomination_params)

    if @reversenomination.save
      redirect_to root_path, notice: '逆指名送信を完了しました！'
    else
      render 'new'
    end
  end

  def show
  end

  def confirm
    @reversenomination = Reversenomination.new(
      artist_id:params[:artist_id], event_id:params[:event_id], reversenomination_params[:privilege])
    @artist = Artist.find(@reversenomination.artist_id)
    @event = Event.find(@reversenomination.event_id)
    render :new if @reversenomination.invalid?
  end

  def searchinfo
    @q = Event.ransack(params[:q])
  end

  def search
    @artist = Artist.find(params[:artist_id])
    respond_to do |format|
      @q = Event.ransack(params[:q])
      @results = @q.result
      @results = @results.page(params[:page]).per(3)

      format.html { redirect_to searchinfo_reversenominations_path }
      format.js { render :searchinfo }
    end

  end

  private
    def reversenomination_params
      params.require(:reversenomination).permit(:artist_id, :event_id, :privilege)
    end

end
