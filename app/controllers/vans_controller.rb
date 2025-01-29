class VansController < ApplicationController
  before_action :van_find, only: [:show]

  def index
    @vans = Van.all
  end

  def show
    @user = @van.user
    @products = @van.products
    @inventories = @van.inventories.includes(:product)
  end

end

private

def van_find
  @van = Van.find(params[:id])
end
