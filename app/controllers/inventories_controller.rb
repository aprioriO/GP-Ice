class InventoriesController < ApplicationController

  def index
    @van = Van.find(params[:van_id])
    @inventories = @van.inventories
    @user = current_user
  end

  def show
    @van = Van.find(params[:van_id])
    @inventory = @van.inventories.find_by(id: params[:id])
    if @inventory.nil?
      redirect_to van_inventories_path(@van), alert: 'Inventory not found'
    end
  end

  def new
    @van = Van.find(params[:van_id])
    @inventory = Inventory.new
    @inventory.van = @van
    @products = Product.all
  end

  def create
    @van = Van.find(params[:van_id])
    @product = Product.find(params[product_id: :product_id])
    @inventory = @van.inventories.find_or_initialize_by(product: @product)
    @inventory.quantity_avilable = params[:quantity_available]
    @inventory.price = params[:price]
    # @inventory.user = current_user
    @inventory.van = @van
    if @inventory.save
      flash[:notice] = "Inventory created"
      redirect_to van_inventories_path(@inventory.van)
    else
      render :new
    end
  end
end
