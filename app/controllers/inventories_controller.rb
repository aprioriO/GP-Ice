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
    @inventory = @van.inventories.new
    @products = Product.all
    end
  end

  def create
    @van = Van.find(params[:van_id])
    @inventory = @van.inventories.new(inventory_params)
    if @inventory.save
      redirect_to van_inventories_path(@van, @inventory), notice: 'Inventory created'
    else
      render :new
    end
  end

  def create
    @inventory = @van.inventories.new(inventory_params)
    @inventory.user = current_user
    @inventory.van = @van
    @inventory.quantity_avaliable = 0
    @inventory.price = 0
    @product = Product.find(params[:product_id])
    if @inventory.save
      flash[:notice] = "Inventory created"
      redirect_to van_inventories_path(@inventory.van)
    else
      render :new
    end
  end
