require 'rails_helper'

RSpec.describe Artist, type: :model do
  before(:context) do
    Artist.create(spotify_id: "blahhh1", name: "A Moon Men", city: "Rockford", state: "IL", followers: 1)
    Artist.create(spotify_id: "blahhh2", name: "B Moon Women", city: "Rockford", state: "IL", followers: 2)
    Artist.create(spotify_id: "blahhh3", name: "C Moon Frog", city: "Denver", state: "CO", followers: 3)
  end

  after(:context) do
    Artist.destroy_all
  end

  context "validations" do
    it { should validate_presence_of(:spotify_id) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:followers) }
  end

  context "helper model methods" do
    it "returns all artists in a city" do
      expect(Artist.all.count).to eq(3)
      expect(Artist.index_by_city("Rockford","IL").count).to eq(2)
    end
  end
end
