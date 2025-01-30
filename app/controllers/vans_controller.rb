class VansController < ApplicationController

  before_action :van_find, only: [:show]
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def orders
    @van = Van.find(params[:van_id])
    @orders = @van.orders
  end


  def index
    @vans = Van.all
    @markers = @vans.geocoded.map do |van|
      {
        lat: van.latitude,
        lng: van.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {van: van}),
        marker_html: render_to_string(partial: "marker", locals: {van: van})
      }
    end
  end

  def show
    @user = @van.user
    @products = @van.products
    @inventories = @van.inventories.includes(:product)
    # @inventory_product = @inventories.find_by(product_id: params[:id])
  end

end

private

def van_find
  @van = Van.find(params[:id])
end
