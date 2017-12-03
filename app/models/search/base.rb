class Search::Base
  include ActiveModel::Model
  include ActiveModel::Validations::Callbacks

  def contains(arel_attribute, value)
    binding.pry
    arel_attribute.matches("%#{escape_like(value)}%")
  end

  def escape_like(string)
    binding.pry
    string.gsub(/[\\%_]/) { |m| "\\#{m}" }
  end

end
