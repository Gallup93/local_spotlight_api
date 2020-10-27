class Artist < ApplicationRecord
  validates :name, presence: true
  validates :spotify_id, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :followers, presence: true

  def self.index_by_city(city, state)
    Artist.where(["city = ? and state = ?", "#{city}", "#{state}"])
  end
end
