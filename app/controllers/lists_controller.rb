class ListsController < ApplicationController
  before_action :set_list, only: [:show]
  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def index
    @list = List.new
    @movies = Movie.all
    @lists = List.all
  end

  def update
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name)
  end
end
