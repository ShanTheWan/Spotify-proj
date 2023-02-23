class TracksController < ApplicationController
  before_action :set_track, only: %i[ show edit update destroy self.ransackable_attributes ]
  before_action :authenticate_user!, except: %i[ index show ]
  before_action :authorize_user!, only: %i[ edit update destroy ]

  # GET /tracks or /tracks.json
  def index
    @tracks = Track.published

    if params[:search].present?
      @tracks = @tracks.where("title LIKE ?", "%#{params[:search]}%").or(Track.joins(:user).where("users.name LIKE ?", "%#{params[:search]}%"))
    end
    
  end

  # GET /tracks/1 or /tracks/1.json
  def show
  end

  # GET /tracks/new
  def new
    @track = Track.new
  end

  # GET /tracks/1/edit
  def edit
  end

  # POST /tracks or /tracks.json
  def create
    @track = Track.new(track_params)
    @track.user = current_user

    respond_to do |format|
      if @track.save
        format.html { redirect_to track_url(@track), notice: "Track was successfully created." }
        format.json { render :show, status: :created, location: @track }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @track.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tracks/1 or /tracks/1.json
  def update
    respond_to do |format|
      if @track.update(track_params)
        format.html { redirect_to track_url(@track), notice: "Track was successfully updated." }
        format.json { render :show, status: :ok, location: @track }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @track.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tracks/1 or /tracks/1.json
  def destroy
    @track.destroy

    respond_to do |format|
      format.html { redirect_to tracks_url, notice: "Track was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def my_tracks
    @tracks = current_user.tracks
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_track
      @track = Track.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def track_params
      params.require(:track).permit(:title, :body, :file, :published_at)
    end

    def authorize_user!
      unless @track.user == current_user
        redirect_to root_path, notice: "You don't have permissions to do that!" 
      end
    end
end
