class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_van, only: [:show]

  def show
    @user = @van.user
    # @products = @van.products
    # @inventories = @van.inventories.includes(:product)
    # @product_to_buy = @van.inventories.find_by(product_id: params[:id])
    @product_to_buy = @van.inventories.find_by(product_id: params[:id])

    @photo = @product_to_buy.photo
    @name = @product_to_buy.product.name
    @description = @product_to_buy.product.description
    @price = @product_to_buy.product.price
  end

  private
  def set_van
    @van = Van.find_by(id: params[:van_id])
    unless @van
      redirect_to root_path, alert: 'Van not found'
    end
  end
end
