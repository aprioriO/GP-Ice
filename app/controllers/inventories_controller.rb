class InventoriesController < ApplicationController
  before_action :set_van, only: [:index, :show, :new, :create]
  before_action :set_products, only: [:new, :create]
  before_action :set_product, only: [:new, :create]
  before_action :build_inventory, only: :create

  def index
    # @van = Van.find(params[:van_id])
    @inventories = @van.inventories
    @user = current_user
  end

  def show
    # @van = Van.find(params[:van_id])
    @inventory = @van.inventories.find_by(id: params[:id])
    if @inventory.nil?
      redirect_to van_inventories_path(@van), alert: 'Inventory not found'
    end
  end

  def new
    @inventory = Inventory.new
    @inventory.van = @van
  end

  def create
    if @inventory.save
      flash[:notice] = "Inventory created"
      redirect_to van_inventories_path(@inventory.van)
    else
      flash[:alert]  = "Inventory not created"
      render :new
    end
  end

  private

  def inventory_params
    params.require(:inventory).permit(:product_id, :quantity_available, :price)
  end

  def set_van
    @van = Van.find(params[:van_id])
  end

  def set_products
    @products = Product.all
  end

  def set_product
    @product = Product.find_or_initialize_by(id: params[:product_id])
  end

  def build_inventory
    @inventory = Inventory.new(inventory_params)
    # @inventory.price = params[:price]
    # @van.user = current_user
    @inventory.van = @van
  end
end
