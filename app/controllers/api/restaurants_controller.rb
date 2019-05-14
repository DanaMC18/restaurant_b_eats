class Api::RestaurantsController < ApplicationController

  # URL:    api/restaurants/search
  # PARAMS: params[:cuisine]  = name of cuisine
  #         params[:grade]    = restaurant grade
  def index
    cuisine       = params[:cuisine].try(:strip)
    grade         = params[:grade].try(:strip)
    @restaurants  = search_by_cuisine_and_grade(cuisine, grade)
  end

  private

  def search_by_cuisine_and_grade(cuisine, grade)
    Builders::RestaurantQueries::SearchBuilder.search(cuisine, grade)
  end
end
