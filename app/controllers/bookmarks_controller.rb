class BookmarksController < ApplicationController
  # before_action :set_list, only: [:create]
  def new
    @list = List.find(params[:list_id])
    # @movies = Movie.all
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = List.find(params[:list_id])
    @bookmark.movie = Movie.find(params[:bookmark][:movie_id])
    if @bookmark.save
      redirect_to list_path(@bookmark.list)
    else
      flash[:alert] = @bookmark.errors.full_messages.to_sentence
      redirect_to new_list_bookmark_path(@bookmark.list)
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list)
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id, :list_id)
  end

  # def set_list
  #   @list = List.find(params[:list_id])
  # end
end
