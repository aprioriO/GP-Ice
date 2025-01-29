class ProductsController < ApplicationController
  before_action :authenticate_user!
  def show
    @van = Van.find(params[:van_id])
    @user = @van.user
    @product_to_buy = @van.inventories.product(params[:id])
  end

  private
  def van_find
    @van = Van.find(params[:id])
  end

end
