class InventoriesController < ApplicationController

  def index
    @van = Van.find(params[:van_id])
    @inventories = @van.inventories
  end

  def show
    @van = Van.find(params[:van_id])
    @inventory = @van.inventories.find_by(id: params[:id])
    if @inventory.nil?
      redirect_to van_inventories_path(@van), alert: 'Inventory not found'
    end
  end
end
