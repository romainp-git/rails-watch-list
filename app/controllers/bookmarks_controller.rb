class BookmarksController < ApplicationController
  before_action :set_bookmark, only: [:show, :destroy]
  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    if @bookmark.save
      redirect_to movies_path()
    else
      @list = List.new

      @movies = Movie.all
      @lists = List.all
      @genres = Genre.all
      render 'movies/index', status: :unprocessable_entity
    end
  end

  def show
  end

  def index
    @bookmark = Bookmark.new
    @bookmarks = Bookmark.all
  end

  def update
  end

  def destroy
    @bookmark.destroy
    redirect_to lists_path, status: :see_other
  end

  private

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:comment, :list_id, :movie_id)
  end
end
