class Search::Artist < Search::Base
  ATTRIBUTES = %i(
    name
    genre
  )

  attr_accessor(*ATTRIBUTES)

  def matches
    t = ::Artist.arel_table
    results = ::Artist.all
    results = results.where(contains(t[:name], name)) if name.present?
    results = results.where(contains(t[:genre], genre)) if genre.present?
  end

end
