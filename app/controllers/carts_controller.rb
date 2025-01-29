class CartsController < ApplicationController
  before_action :set_van

  def show
    @cart = session[:cart] || {}
    @products = Product.where(id: @cart.keys)
  end

  def add
    session[:cart] ||= {}
    product_id = params[:product_id]

    session[:cart][product_id] = session[:cart][product_id].to_i + 1
    redirect_to van_cart_path(@van), notice: "Product added to cart!"
  end

  def remove
    session[:cart] ||= {}
    product_id = params[:product_id]

    session[:cart].delete(product_id)
    redirect_to van_cart_path(@van), notice: "Product removed from cart."
  end

  def clear
    session[:cart] = {}
    redirect_to van_cart_path(@van), notice: "Cart cleared."
  end

  private

  def set_van
    @van = Van.find(params[:van_id])
  end
end
