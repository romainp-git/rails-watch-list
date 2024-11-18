class MoviesController < ApplicationController
  def index
    @list = List.new
    @bookmark = Bookmark.new

    @lists = List.all
    @genres = Genre.all
    @movies = Movie.all
  end
end
