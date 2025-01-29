class OrdersController < ApplicationController

  def index
    @orders = Order.where(user_id: current_user.id)
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


  private
   def order_params
    params.require(:order).permit(:confirmed_status)
  end
end
