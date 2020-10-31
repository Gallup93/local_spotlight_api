require 'rails_helper'

 RSpec.describe "artist creation requests" do
   before(:context) do
     @token = get_token
     @auth_header = { "HTTP_AUTHORIZATION" => "Bearer " + @token }
     @auth_header_invalid = { "HTTP_AUTHORIZATION" => "Bearer " + "BrokenToken" }
   end

   after(:context) do
     Artist.destroy_all
     User.destroy_all
   end

   query_valid = { "spotify_id":"1LB8qB5BPb3MHQrfkvifXU", "city":"Rockford", "state":"IL" }
   query_invalid_id = { "spotify_id":"XXXXXXXBPb3MHQrXXXXXXX", "city":"Rockford", "state":"IL" }

   context "a valid request" do
     it "creates artist and returns artist id" do
       post "/api/v1/artists", params: query_valid, headers: @auth_header
       response = JSON.parse(@response.body)
       expect(response["artist"]).to eq(Artist.last.id)
     end
   end

   context "artist already exists" do
     it "returns error message and existing artist's id" do
       post "/api/v1/artists", params: query_valid, headers: @auth_header
       post "/api/v1/artists", params: query_valid, headers: @auth_header
       response = JSON.parse(@response.body)
       expect(response["error"]["message"]).to eq("Artist already exists")
     end
   end

   context "invalid spotify id" do
     it "returns an error message" do
       post "/api/v1/artists", params: query_invalid_id, headers: @auth_header
       response = JSON.parse(@response.body)
       expect(response["error"]["message"]).to eq("Invalid Spotify ID")
     end
   end

   def get_token
     User.create(username: "Devin Hester", email: "ridiculous23@gmail.com", password: "password", password_confirmation: "password")
     query_login = { user: { "email": "ridiculous23@gmail.com", "password": "password" } }
     post "/api/v1/users/login", params: query_login
     response = JSON.parse(@response.body)
     response["auth_token"]
   end
 end
