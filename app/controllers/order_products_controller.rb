class OrderProductsController < ApplicationController
  before_action :set_van
  before_action :set_order

  def show
    @cart_items = @order.order_products.includes(:product) if @order
    render "carts/show"
  end

  def create
    @product = Product.find(params[:product_id])
    @order_product = @order.order_products.find_or_initialize_by(product: @product)
    @order_product.quantity_ordered = params[:order][:quantity_ordered].to_i if params[:order][:quantity_ordered].present?

    if @order_product.save
      redirect_to van_cart_path(@van), notice: "Product added to cart."
    else
      redirect_to van_cart_path(@van), alert: "Failed to add product."
    end
  end

  def destroy
    @order_product = @order.order_products.find(params[:id])
    message = @order_product.destroy ? "Product removed from cart." : "Failed to remove product."
    redirect_to van_cart_path(@van), notice: message
  end

  private

  def set_van
    @van = Van.find(params[:van_id])
  end

  def set_order
    @order = Order.find_or_create_by(user: current_user, van: @van, confirmed_status: false)
  end
end
