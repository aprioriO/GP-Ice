class FavouritesController < ApplicationController
  before_action :set_van, only: [:create]

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
    set_van unless @favourite.van
    @van = @favourite.van
    @favourite.destroy
    # redirect_to van_path, notice: "Removed from favourites."

    if request.referer.include?(van_path(@favourite.van))
      redirect_to van_path(@favourite.van), notice: "Removed from favourites."
    elsif request.referer.include?(favourites_path)
      redirect_to favourites_path, notice: "Removed from favourites."
    else
      redirect_to root_path, alert: "Removed from favourites, but we couldn't determine the source page."
    end
  end

  private
  def set_van
    @van = Van.find(params[:van_id])
  end

  def favourites_params
    params.require(:favourite).permit(:van_id, :user_id)
  end
end
