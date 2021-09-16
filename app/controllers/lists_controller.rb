class ListsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :find_list, only: [:show, :destroy]

  def index
    @lists = List.where("user_id = ?", current_user)
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.user = current_user
    @list.image_url = "https://source.unsplash.com/featured/?#{list_params[:name]}"
    if @list.save
      redirect_to list_path(@list)
    else
      render :new
    end
  end

  def show
    @review = Review.new
  end

  def destroy
    @list.destroy
    redirect_to lists_path
  end


  private

  def find_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :cover, :image_url)
  end
end
