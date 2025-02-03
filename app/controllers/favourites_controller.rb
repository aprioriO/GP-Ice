class FavouritesController < ApplicationController
  before_action :set_van, only: [:new, :create]

  def index
    @user = current_user
    @favourites = @user.favourites
  end

  def new
    @favourites = Favourite.new
    @favourites.van = @van
  end

  def create
    @favourites = Favourite.new(favourites_params)
    @favourites.van = @van
    if @favourites.save
      flash[:notice] = "favourites added"
      redirect_to favourites_path
    else
      flash[:alert]  = "favourites not added"
      render :new
    end
  end

  def destroy
    @favourite = Favourite.find(params[:id])
    @favourite.destroy
    redirect_to favourites_path
  end

  private
  def set_van
    @van = Van.find(params[:van_id])
  end

  def favourites_params
    params.require(:favourite).permit(:van_id, :user_id)
  end
end
