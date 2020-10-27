class CreateArtists < ActiveRecord::Migration[5.1]
  def change
    create_table :artists do |t|
      t.string :spotify_id
      t.string :name
      t.string :city
      t.string :state
      t.bigint :followers
    end
  end
end
