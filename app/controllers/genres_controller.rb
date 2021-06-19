class GenresController < ApplicationController

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    genre = Genre.new(genre_params)
    genre.save
    redirect_to genres_path
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
  end

  private
  def genre_params
    params.require(:genres).permit(:name)
  end
end