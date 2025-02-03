class OrderProductsController < ApplicationController
  before_action :set_order

  def show
    @cart_items = Order.where(user: current_user, status: "pending").includes(order_products: :product)
    render "carts/show"
  end

  def create
    @product = Product.find(params[:product_id])
    @van = @product.inventories.first.van

    @order = Order.find_or_create_by(user: current_user, van: @van, confirmed_status: false, status: "pending")
    @order_product = @order.order_products.find_or_initialize_by(product: @product)

    if params[:order][:quantity_ordered].present?
      @order_product.quantity_ordered = params[:order][:quantity_ordered].to_i
    end

    if @order_product.save
      redirect_to cart_path, notice: "Product added to cart."
    else
      redirect_to cart_path, alert: "Failed to add product."
    end
  end

  def destroy
    @order_product = OrderProduct.find(params[:id])

    if @order_product.destroy
      redirect_to cart_path, notice: "Product removed from cart."
    else
      redirect_to cart_path, alert: "Failed to remove product."
    end
  end

  private

  def set_order
    @orders = Order.where(user: current_user, status: "pending")
  end
end
