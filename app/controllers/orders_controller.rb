class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = Order.where(user_id: current_user.id)
  end

  def new
    @order = Order.new
    @products = Product.all
  end

  def create
    @order = Order.create(user: current_user, confirmed_status: false, paid_status: false)
    if params[:product_ids].present?
      params[:product_ids].each { |product_id| @order.order_products.create(product_id: product_id) }
    end
    redirect_to checkout_order_path(@order)
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(confirmed_status: true)
      redirect_to van_orders_path(@order.van), notice: 'Order confirmed.'
    else
      redirect_to van_orders_path(@order.van), alert: 'Failed to confirm order.'
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to van_orders_path(@order.van), notice: 'Order deleted.'
  end

  def checkout
    @order = Order.find(params[:order_id])

    if @order.update(confirmed_status: true)
      flash[:notice] = "Order successfully checked out!"
      render :checkout
    else
      redirect_to order_path(@order), alert: "Checkout failed."
    end
  end

  private

  def order_params
    params.require(:order).permit(:confirmed_status)
  end
end
