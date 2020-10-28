require 'rails_helper'

RSpec.describe "user login requests" do
  before(:context) do
    User.create(username: "Devin Hester", email: "ridiculous23@gmail.com", password: "password", password_confirmation: "password")
  end

  after(:context) do
    User.destroy_all
  end

  query_valid = {
    user: {
      "email": "ridiculous23@gmail.com",
      "password": "password"
    }
  }
  query_invalid_email = {
    user: {
      "email": "",
      "password": "password"
    }
  }
  query_invalid_password = {
    user: {
      "email": "ridiculous23@gmail.com",
      "password": ""
    }
  }

  context "a valid request" do
    it "returns a token" do
      post '/api/v1/users/login', params: query_valid
      response = JSON.parse(@response.body)

      expect(response["auth_token"].length).to eq(139)
    end
  end

  context "an invalid email" do
    it "returns an error message" do
      post '/api/v1/users/login', params: query_invalid_email
      response = JSON.parse(@response.body)

      expect(response["error"]).to eq("Invalid username/password")
    end
  end

  context "an invalid password" do
    it "returns an error message" do
      post '/api/v1/users/login', params: query_invalid_password
      response = JSON.parse(@response.body)

      expect(response["error"]).to eq("Invalid username/password")
    end
  end
end
