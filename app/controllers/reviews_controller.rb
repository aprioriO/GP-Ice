class ReviewsController < ApplicationController


  def index
    @van = Van.find(params[:van_id])
    @orders = Order.where(van_id: @van.id)
    @users = User.where(id: @orders.pluck(:user_id))
    @reviews = Review.where(order_id: @orders.pluck(:id))
  end


  def show
    @order = Order.find(params[:order_id])
    @van = Van.find(@order.van_id)
    @review = Review.find(params[:id])
  end

  def new
    # @van = Van.find_by(id: params[:van_id])
    @order = Order.find(params[:order_id])
    # if @van.nil?
    #   flash[:alert] = "Van not found"
    #   redirect_to root_path and return
    # end
    @review = Review.new
  end


  def create
    @review = Review.new(review_params)
    @order = Order.find(params[:order_id])
    @review.order_id = @order.id
    # @van = Van.find(params[:van_id])
    if @review.save!
      redirect_to orders_path, notice: "Review created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end




  private



  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
