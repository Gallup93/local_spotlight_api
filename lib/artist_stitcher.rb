require 'spotify_helper'

class ArtistStitcher
  def initialize(artist_params)
    @artist = Artist.new(artist_params)
    @spotify_object = SpotifyHelper.new.get_artist(@artist.spotify_id)
  end

  def stitch
    if @spotify_object["name"]
      @artist.name = @spotify_object["name"]
      @artist.followers = @spotify_object["followers"]["total"]
      @artist
    else
      { error: { "status": 404, "message": "Invalid Spotify ID" } }
    end
  end
end
