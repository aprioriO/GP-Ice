class OrderProductsController < ApplicationController
  before_action :set_order

  def create
    @product = Product.find(params[:product_id])
    @order_product = @order.order_products.new(product: @product)

    if @order_product.save
      redirect_to order_path(@order), notice: "Product added to order."
    else
      redirect_to order_path(@order), alert: "Failed to add product."
    end
  end

  def destroy
    @order_product = @order.order_products.find(params[:id])

    if @order_product.destroy
      redirect_to order_path(@order), notice: "Product removed from order."
    else
      redirect_to order_path(@order), alert: "Failed to remove product."
    end
  end

  private

  def set_order
    @order = Order.find(params[:order_id])
  end
end
