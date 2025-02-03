class CartsController < ApplicationController
  class CartsController < ApplicationController
    def index
      @orders = Order.where(user: current_user, status: "pending").includes(:order_products, :van)
    end
  end
end
