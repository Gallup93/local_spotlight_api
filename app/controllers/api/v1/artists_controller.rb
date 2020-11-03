class Api::V1::ArtistsController < ApplicationController
  before_action :authenticate_request!

  def index
    @artists = ArtistCompiler.new(params[:artist]).artists
    render json: { artists: @artists }, status: :ok
  end

  def create
    artist = ArtistStitcher.new(artist_params).stitch
    if artist.class == Hash
      render json: artist, status: :unprocessable_entity
    elsif artist.save
      render json: { artist: Artist.last.id }, status: 201
    else
      render json: { error: { message: "Artist already exists", artist_id: Artist.find_by_spotify_id(artist_params["spotify_id"]).id }}, status: 400
    end
  end

  private

  def artist_params
    params.permit(:spotify_id, :city, :state)
  end
end
