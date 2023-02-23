class MyTracksController < ApplicationController
  before_action :authenticate_user!

  def index
    @my_tracks = current_user.tracks
  end
end
