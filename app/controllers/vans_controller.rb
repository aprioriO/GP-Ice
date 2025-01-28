class VansController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @vans = Van.all
  end

  def show
    @van = Van.find(params[:id])
  end
end
