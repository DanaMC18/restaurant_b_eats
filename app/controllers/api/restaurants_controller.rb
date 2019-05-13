class Api::RestaurantsController < ApplicationController

  # URL:    api/restaurants/search
  # PARAMS: params[:cuisine]  = name of cuisine
  #         params[:grade]    = restaurant grade
  def index
    @cuisine      = params[:cuisine].try(:strip!)
    @restaurants  = search_by_cuisine(@cuisine)
  end

  private

  def search_by_cuisine
    return [] unless 
    Restaurant.search_by_cuisine_description(@cuisine)
  end

  def search_by_latest_inspection_grade
  end
end
