class ArtistsController < ApplicationController
  before_action :set_artist, only:[:show, :edit, :update, :destroy]

  def show
  end

  def new
    if  params[:back]
      @artist = Artist.new(artist_params)
    else
      @artist = Artist.new
    end
  end

  def create
    @artist = Artist.create(artist_params)
    @artist.user_id = current_user.id

    if @artist.save
      redirect_to events_path, notice: "アーティスト登録が完了しました！"
    else
      render 'new'
    end

  end

  def edit
  end

  def update
    if @artist.update(artist_params)
      redirect_to events_path, notice: "アーティスト情報を更新しました！"
    else
      render 'new'
    end
  end

  def confirm
    @artist = Artist.new(artist_params)
    render 'new' if @artist.invalid?
  end

  private
    def artist_params
      params.require(:artist).permit(:name, :genre, :self_introduction, :singing, :play_video, :avatar)
    end

    def set_artist
      @artist = Artist.find_by(user_id: params[:id])
    end

end
