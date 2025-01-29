class OrderProductsController < ApplicationController
  before_action :set_order, only: [:create, :destroy, :show]

  def show
    @van = Van.find(params[:van_id])
    @cart = session[:cart] || []
    @products = Product.where(id: @cart)
    render "carts/show"
  end

  def create
    @product = Product.find(params[:product_id])
    @order_product = @order.order_products.find_or_initialize_by(product: @product)

    if @order_product.save
      redirect_to van_cart_path(@order.van), notice: "Product added to cart."
    else
      redirect_to van_cart_path(@order.van), alert: "Failed to add product."
    end
  end

  def destroy
    @order_product = @order.order_products.find(params[:id])

    if @order_product.destroy
      redirect_to van_cart_path(@order.van), notice: "Product removed from cart."
    else
      redirect_to van_cart_path(@order.van), alert: "Failed to remove product."
    end
  end

  private

  def set_order
    @order = Order.find_or_create_by(user: current_user, confirmed_status: false)
  end
end
