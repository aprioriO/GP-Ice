class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def search
    @postcode = params[:postcode]

    flash[:notice] = "You searched for #{@postcode}" unless @postcode.blank?
    render :index
  end
end
