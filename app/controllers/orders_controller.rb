class OrdersController < ApplicationController

  before_action :authenticate_user!


  def index
    @orders = Order.where(user_id: current_user.id)
    @vans = @orders.map(&:van).uniq
    if params[:van_id].present?
      @selected_van = Van.find(params[:van_id])
      @orders = @orders.where(van_id: @selected_van.id)
    end

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

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
