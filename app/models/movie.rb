# frozen_string_literal: true

# Represents a movie in the application.
#
# The `Movie` class inherits from `ApplicationRecord` and represents a movie entity in the database.
# It has a one-to-many association with the `Bookmark` class.
#
# Example usage:
#   movie = Movie.new(title: 'Example Movie', overview: 'This is an example movie.')
#   movie.save
class Movie < ApplicationRecord
  has_many :bookmarks

  validates :title, presence: true, uniqueness: true
  validates :overview, presence: true
end
