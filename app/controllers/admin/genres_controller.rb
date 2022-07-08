class Admin::GenresController < ApplicationController
  
  def create
    genre = Genre.new(genre_params)
    genre.save
    redirect_to admin_genres_path
  end
  
  def index
    @genres = Genre.all
    @genre = Genre.new
  end
  
  def edit
    @genre = Genre.find(params[:id])
  end
  
  def update
  end
  
  private
  
  def genre_params
    params.require(:genre).permit(:name)
  end

end
