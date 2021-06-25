class Admin::GenresController < ApplicationController
  #管理者側ジャンルページ

  before_action :authenticate_admin!

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    genre = Genre.new(genre_params)
    genre.save
    redirect_to admin_genres_path
    flash[:notice] = '新しいジャンルを作成しました。'
  end

  def edit
    @genre = Genre.find(params[:id])
  end


  def update
    @genre = Genre.find(params[:id])
    @genre.update(genre_params)
    redirect_to admin_genres_path
    flash[:notice] = 'ジャンルを削除しました。'
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    redirect_to admin_genres_path
    flash[:notice] = 'ジャンルの修正が完了しました。'
  end



  private
  def genre_params
    params.require(:genre).permit(:name)
  end
end