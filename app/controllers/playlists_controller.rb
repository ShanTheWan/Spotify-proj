# app/controllers/playlists_controller.rb
class PlaylistsController < ApplicationController
  before_action :set_playlist, only: %i[show edit update destroy self.ransackable_attributes]
  before_action :authenticate_user!, except: %i[index show]
  before_action :authorize_user!, only: %i[edit update destroy]

  def index
    @playlists = Playlist.all
  end

  def show
    @playlist&.title
  end

  def new
    @playlist = Playlist.new
  end

  def edit
  end

  def create 
    @playlist = Playlist.new(playlist_params)
    @playlist.user = current_user
  
    respond_to do |format|
      if @playlist.save
        format.html { redirect_to playlist_url(@playlist), notice: "Playlist was successfully created." }
        format.json { render :show, status: :created, location: @playlist }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end  

  def update
    respond_to do |format|
      if @playlist.update(playlist_params)
        format.html { redirect_to playlist_url(@playlist), notice: "Playlist was successfully updated." }
        format.json { render :show, status: :ok, location: @playlist }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @playlist.destroy

    respond_to do |format|
      format.html { redirect_to playlists_url, notice: "Playlist was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  def add_track
    @playlist = Playlist.find(params[:id])
    @track = Track.find(params[:track_id])
    @playlist.tracks << @track
    redirect_to playlist_path(@playlist)
  end

  def remove_track
    @playlist = Playlist.find(params[:playlist_id])
    @track = Track.find(params[:id])
    @playlist.tracks.delete(@track)
    redirect_to playlist_path(@playlist)
  end
  
  private

  def set_playlist
    @playlist = Playlist.find(params[:id])
  end

  def playlist_params
    params.require(:playlist).permit(:title)
  end

  def authorize_user!
    unless @playlist.user_id == current_user.id
      redirect_to root_path, alert: "Not Authorized"
    end
  end
end
