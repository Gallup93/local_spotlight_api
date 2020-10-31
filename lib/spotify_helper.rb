class SpotifyHelper
  require "base64"
  require 'uri'
  require "net/http"

  def initialize
    @auth_token = get_spotify_auth_token
  end

  def get_spotify_auth_token
    url = URI("https://accounts.spotify.com/api/token")

    https = Net::HTTP.new(url.host, url.port);
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["Authorization"] = "Basic #{ENV['SPOTIFY_CLIENT_ENCODED']}"
    request["Content-Type"] = "application/x-www-form-urlencoded"
    request.body = "grant_type=client_credentials"

    response = https.request(request)
    JSON.parse(response.read_body)["access_token"]
  end

  def get_artist(id)
    url = URI("https://api.spotify.com/v1/artists/#{id}")

    https = Net::HTTP.new(url.host, url.port);
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["Authorization"] = "Bearer #{@auth_token}"

    response = https.request(request)
    JSON.parse(response.read_body)
  end
end
