class OrderProductsController < ApplicationController
  before_action :set_van
  before_action :set_order

  def show
    @cart_items = @order.order_products.includes(:product)
    render "carts/show"
  end

  def create
    @product = Product.find(params[:product_id])
    @order_product = @order.order_products.find_or_initialize_by(product: @product)
    @order_product.quantity_ordered = params[:quantity_ordered]

    if @order_product.save
      redirect_to van_cart_path(@van), notice: "Product added to cart."
    else
      redirect_to van_cart_path(@van), alert: "Failed to add product."
    end
  end

  def destroy
    @order_product = @order.order_products.find(params[:id])

    if @order_product.destroy
      redirect_to van_cart_path(@van), notice: "Product removed from cart."
    else
      redirect_to van_cart_path(@van), alert: "Failed to remove product."
    end
  end

  private

  def set_van
    @van = Van.find(params[:van_id])
  end

  def set_order
    @order = Order.find_or_create_by(user: current_user, status: "pending", van: @van)
  end
end
