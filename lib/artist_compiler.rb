class ArtistCompiler
  attr_reader :artists
  def initialize(params)
    city = params[:city]
    state = params[:state]
    @artists = get_artists(city, state)
    sort_artists(params[:sort])
  end

  def get_artists(city, state)
    Artist.index_by_city(city, state)
  end

  def sort_artists(sort_key)
    if sort_key == "alphabetical"
      @artists = @artists.order('LOWER(name)')
    elsif sort_key == "followers"
      @artists = @artists.order(followers: :desc)
    else
      @artists = @artists.shuffle
    end
  end
end
