class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = Order.new
    @products = Product.all
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to @order, notice: "Order created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @order = Order.find(params[:id])
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

  def index
    @orders = Order.all
  end
end
