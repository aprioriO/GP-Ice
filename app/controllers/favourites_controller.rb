class FavouritesController < ApplicationController
  before_action :set_van, only: [:create, :destroy]

  def index
    @user = current_user
    @favourites = @user.favourites
  end

  def create
    Favourite.create!(van: @van, user: current_user)
    redirect_to van_path(@van)
  end

  def destroy
    @favourite = Favourite.find(params[:id])
    @favourite.destroy
    redirect_back fallback_location: van_path, notice: "Removed from favourites."
  end

  private
  def set_van
    @van = Van.find(params[:van_id])
  end

  def favourites_params
    params.require(:favourite).permit(:van_id, :user_id)
  end
end
