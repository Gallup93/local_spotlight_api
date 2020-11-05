class Artist < ApplicationRecord
  validates :name, presence: true
  validates :spotify_id, presence: true, uniqueness: true
  validates :city, presence: true
  validates :state, presence: true
  validates :followers, presence: true
  before_save :downcase_city
  before_save :upcase_state

  def self.index_by_city(city, state)
    Artist.where(["city = ? and state = ?", "#{city.downcase}", "#{state.upcase}"])
  end

  def self.find_by_spotify_id(id)
    Artist.find_by("spotify_id = ?", id)
  end

  def downcase_city
    self.city.downcase!
  end

  def upcase_state
    self.state.upcase!
  end
end
