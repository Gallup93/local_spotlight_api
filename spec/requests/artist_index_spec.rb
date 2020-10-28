require 'rails_helper'

 RSpec.describe "artist index requests" do
   before(:context) do
     Artist.create(followers: 5000, name: "Taboo Blah Blah", spotify_id: "77WeI8znTJNL9VgXxJVfOO", city: "Rockford", state: "IL")
     Artist.create(followers: 3800, name: "Pink Beam", spotify_id: "1jAlXWRhCvBrpnX8avLVRP", city: "Rockford", state: "IL")
     Artist.create(followers: 666, name: "Purple Hell", spotify_id: "3EusnQEaJ7atdju9f3QoB0", city: "Rockford", state: "IL")
     Artist.create(followers: 16000, name: "Quilt Club", spotify_id: "5PxhTwi9zUw26P4UUBuRs6", city: "Rockford", state: "IL")
     Artist.create(followers: 100000, name: "Name The Moon", spotify_id: "2oWWnEqDToq3n0Hv1zPZQJ", city: "Rockford", state: "IL")

     @token = get_token
     @auth_header = { "HTTP_AUTHORIZATION" => "Bearer " + @token }
     @auth_header_invalid = { "HTTP_AUTHORIZATION" => "Bearer " + "BrokenToken" }
   end

   after(:context) do
     User.destroy_all
     Artist.destroy_all
   end

   query_valid = { artist: { "city":"Rockford", "state":"IL", "sort":"alphabetical" } }
   query_missing_city = { artist: { "city":"", "state":"IL", "sort":"alphabetical" } }
   query_missing_state = { artist: { "city":"Rockford", "state":"", "sort":"alphabetical" } }
   query_missing_sort = { artist: { "city":"Rockford", "state":"IL", "sort":"" } }
   query_random_sort = { artist: { "city":"Rockford", "state":"IL", "sort":"random" } }
   query_followers_sort = { artist: { "city":"Rockford", "state":"IL", "sort":"followers" } }

   context "a valid request" do
     it "returns all artists in database from that city" do
       get "/api/v1/artists", params: query_valid, headers: @auth_header
       response = JSON.parse(@response.body)
       expect(response["artists"].count).to eq(5)
     end
   end

   context "unauthorized request" do
     it "sends an error message" do
       get "/api/v1/artists", params: query_valid, headers: @auth_header_invalid
       response = JSON.parse(@response.body)
       expect(response["error"]).to eq("Invalid Request")
     end
   end

   context "request with missing sort parameter" do
     it "defaults to a random sort" do
       get "/api/v1/artists", params: query_missing_sort, headers: @auth_header
       response = JSON.parse(@response.body)
       expect(response["artists"].count).to eq(5)
     end
   end

   context "requests with a missing city or state" do
     it "returns empty array of matching artist" do
       get "/api/v1/artists", params: query_missing_city, headers: @auth_header
       response = JSON.parse(@response.body)
       expect(response["artists"].count).to eq(0)

       get "/api/v1/artists", params: query_missing_state, headers: @auth_header
       response = JSON.parse(@response.body)
       expect(response["artists"].count).to eq(0)
     end
   end

   context "requests with different sort keys" do
     it "returns artists alphabetically" do
       get "/api/v1/artists", params: query_valid, headers: @auth_header
       response = JSON.parse(@response.body)
       expect(response["artists"].count).to eq(5)
       expect(response["artists"][0]["name"]).to eq("Name The Moon")
       expect(response["artists"][4]["name"]).to eq("Taboo Blah Blah")
     end

     it "returns artists by followers (desc)" do
       get "/api/v1/artists", params: query_followers_sort, headers: @auth_header
       response = JSON.parse(@response.body)
       expect(response["artists"].count).to eq(5)
       expect(response["artists"][0]["name"]).to eq("Name The Moon")
       expect(response["artists"][4]["name"]).to eq("Purple Hell")
     end

     it "returns artists randomly (by selection or default)" do
        get "/api/v1/artists", params: query_random_sort, headers: @auth_header
        response = JSON.parse(@response.body)
        expect(response["artists"].count).to eq(5)

        get "/api/v1/artists", params: query_missing_sort, headers: @auth_header
        response = JSON.parse(@response.body)
        expect(response["artists"].count).to eq(5)
     end
   end

   private

   def get_token
     User.create(username: "Devin Hester", email: "ridiculous23@gmail.com", password: "password", password_confirmation: "password")
     query_login = { user: { "email": "ridiculous23@gmail.com", "password": "password" } }
     post "/api/v1/users/login", params: query_login
     response = JSON.parse(@response.body)
     response["auth_token"]
   end
 end
