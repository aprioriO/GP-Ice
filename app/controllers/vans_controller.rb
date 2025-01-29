class VansController < ApplicationController

  def orders
    @van = Van.find(params[:van_id])
    @orders = @van.orders
  end


end
