class Search::Event < Search::Base
  ATTRIBUTES = %i(
    date
    content
  )

  attr_accessor(*ATTRIBUTES)

  def matches
    t = ::Event.arel_table
    results = ::Event.all
    results = results.where(contains(t[:date], date)) if date.present?
    results = results.where(contains(t[:content], content)) if content.present?
  end

end
