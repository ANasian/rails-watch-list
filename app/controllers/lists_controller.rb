class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.image_url = "https://source.unsplash.com/featured/?#{list_params[:name]}"
    if @list.save
      redirect_to list_path(@list)
    else
      render :new
    end
  end

  def show
    @list = List.find(params[:id])
    @review = Review.new
  end

  private

  def list_params
    params.require(:list).permit(:name, :image_url)
  end
end
