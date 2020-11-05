require 'rails_helper'

RSpec.describe "User creation requests" do
  query_valid = {
    user: {
      "username": "Hank Hill",
      "email": "ProPAIaN@aol.com",
      "password": "password",
      "password_confirmation": "password"
    }
  }
  query_missing_username = {
    user: {
      "username": "",
      "email": "ProPAIaN@aol.com",
      "password": "password",
      "password_confirmation": "password"
    }
  }
  query_missing_email = {
    user: {
      "username": "Hank Hill",
      "email": "",
      "password": "password",
      "password_confirmation": "password"
    }
  }
  query_missing_password = {
    user: {
      "username": "Hank Hill",
      "email": "ProPAIaN@aol.com",
      "password": "",
      "password_confirmation": "password"
    }
  }

  after(:context) do
    User.destroy_all
  end

  context "a valid request" do
    it "succesfully creates a new user and returns token" do
      post '/api/v1/users', params: query_valid
      response = JSON.parse(@response.body)

      expect(response["auth_token"]).to_not eq(nil)
    end
  end

  context "email already exists" do
    it "returns error message" do
      post '/api/v1/users', params: query_valid
      post '/api/v1/users', params: query_valid
      response = JSON.parse(@response.body)

      expect(response["email"]).to eq(["has already been taken"])
    end
  end

  context "missing username" do
    it "returns error message" do
      post '/api/v1/users', params: query_missing_username
      response = JSON.parse(@response.body)

      expect(response["username"]).to eq(["can't be blank"])
    end
  end

  context "missing email" do
    it "returns error message" do
      post '/api/v1/users', params: query_missing_email
      response = JSON.parse(@response.body)

      expect(response["email"]).to eq(["can't be blank"])
    end
  end

  context "missing password" do
    it "returns error message" do
      post '/api/v1/users', params: query_missing_password
      response = JSON.parse(@response.body)

      expect(response["password"]).to eq(["can't be blank"])
    end
  end
end
