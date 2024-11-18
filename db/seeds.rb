# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#

# 1. Clean the database
#
require 'dotenv/load'
puts "Cleaning database..."
Bookmark.destroy_all
Movie.destroy_all
Genre.destroy_all
api_key = ENV['TMDB_API_KEY']
p api_key

# 2. Call API & create Genres 🏗️
response = RestClient.get "https://api.themoviedb.org/3/genre/movie/list", {:Authorization => api_key}
GENRES = JSON.parse(response)['genres']

puts "Creating genres..."
GENRES.each do |genre|
  Genre.find_or_create_by!(name: genre['name'])
end

# 3. Call API & create Movies 🏗️
response = RestClient.get "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=true&language=fr-FR&sort_by=popularity.desc", {:Authorization => api_key}
movies = JSON.parse(response)

puts "Creating movies..."
movies["results"].each do | movie_data |
  movie_data['overview'] = "Aucune description disponible." if movie_data['overview'] == ""

  movie = Movie.create!(
    title: movie_data['title'],
    overview: movie_data['overview'],
    poster_url: "https://image.tmdb.org/t/p/original/#{movie_data['poster_path']}",
    rating: movie_data['vote_average']
  )

  movie_data['genre_ids'].each do |genre_id|
    genre_name = GENRES.find { |genre| genre["id"] == genre_id }["name"]
    genre = Genre.find_by(name: genre_name)
    movie.genres << genre if genre
  end
end

# 4. Display a message 🎉
puts "Finished! Created #{Movie.count} movies."
