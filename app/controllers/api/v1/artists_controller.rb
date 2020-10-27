class Api::V1::ArtistsController < ApplicationController
  before_action :authenticate_request!

  def index
    @artists = ArtistCompiler.new(params[:artist]).artists
    render json: { artists: @artists }, status: :ok
  end
end
