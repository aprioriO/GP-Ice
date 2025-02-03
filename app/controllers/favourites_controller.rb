class FavouritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_van, only: [:new, :create]

  def index

  end

  def new
    @favourites = Favourite.new
    @favourites.van = @van
  end

  def create
    if @favourites.save
      flash[:notice] = "favourites added"
      redirect_to van_favourite_path(@favourites.van)
    else
      flash[:alert]  = "favourites not added"
      render :new
    end
  end

  private
  def set_van
    @van = Van.find(params[:van_id])
  end
end
