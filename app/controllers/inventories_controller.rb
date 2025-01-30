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

end
