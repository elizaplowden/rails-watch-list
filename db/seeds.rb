# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'json'

puts "Cleaning up database..."
Movie.destroy_all
puts "Database cleaned"

# using Le Wagon proxy
url = "http://tmdb.lewagon.com/movie/top_rated"
# 10 movies
10.times do |i|
  puts "Importing movies from page #{i + 1}"
  # parse JSON, open the url and read it. then get results from object
  movies = JSON.parse(open("#{url}?page=#{i + 1}").read)['results']
  # iterate over the movies
  movies.each do |movie|
    puts "Creating #{movie['title']}"
    # svg image
    base_poster_url = "https://image.tmdb.org/t/p/original"
    # create movie object using this info
    Movie.create(
      title: movie['title'],
      overview: movie['overview'],
      # poster url with movie endpoint
      poster_url: "#{base_poster_url}#{movie['backdrop_path']}",
      rating: movie['vote_average']
    )
  end
end
puts "Movies created"
