class Admin::GenresController < ApplicationController
  
  before_action :authenticate_admin!
  
  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path, notice: "新しくジャンルを登録しました"
    else
      @genres = Genre.all
      render :index
    end
  end
  
  def index
    @genres = Genre.all
    @genre = Genre.new
  end
  
  def edit
    @genre = Genre.find(params[:id])
  end
  
  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path, notice: "ジャンル名を更新しました"
    else
      render :edit
    end
  end
  
  def destroy
    genre = Genre.find(params[:id])  
    genre.destroy  
    redirect_to   admin_genres_path
  end
  
  private
  
  def genre_params
    params.require(:genre).permit(:name)
  end

end
