# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'
require 'net/http'

puts 'Cleaning up database...'
Movie.destroy_all
puts 'Database cleaned'

url = 'http://tmdb.lewagon.com/movie/top_rated'
uri = URI(url)
http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Get.new(uri)
response = http.request(request)

10.times do |i|
  puts "Importing movies from page #{i + 1}"
  movies = JSON.parse(response.body)['results']
  movies.each do |movie|
    puts "Creating #{movie['title']}"
    base_poster_url = 'https://image.tmdb.org/t/p/original'
    Movie.create(
      title: movie['title'],
      overview: movie['overview'],
      poster_url: "#{base_poster_url}#{movie['backdrop_path']}",
      rating: movie['vote_average']
    )
  end
end
