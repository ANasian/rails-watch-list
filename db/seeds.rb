require 'json'
require 'open-uri'

puts "Cleaning the DB"
Movie.destroy_all

puts "Seeding the DB"
response = URI.open("http://tmdb.lewagon.com/movie/popular?language=en-US&page=1").read
object = JSON.parse(response)

object["results"].each do |result|
  Movie.create(
    title: result["title"],
    overview: result["overview"],
    poster_url: "https://image.tmdb.org/t/p/w300#{result["poster_path"]}",
    rating: result["vote_average"]
  )
end
puts "Done"
