class Api::RestaurantsController < ApplicationController

  # URL:    api/restaurants/search
  # PARAMS: params[:cuisine]  = name of cuisine
  #         params[:grade]    = restaurant grade
  def search
    cuisine       = params[:cuisine].try(:strip)
    grade         = params[:grade].try(:strip)
    @restaurants  = serialized_restaurants(cuisine, grade)
    render json: @restaurants
  end

  private

  def serialized_restaurants(cuisine, grade)
    restaurants = search_by_cuisine_and_grade(cuisine, grade)
    restaurants.map do |restaurant|
      {
        id:             restaurant.id,
        name:           restaurant.dba,
        type:           restaurant.cuisine.description,
        city_address:   restaurant.city_address,
        phone_number:   restaurant.phone_number,
        grade:          restaurant.current_grade,
        graded_on:      restaurant.current_grade_date.strftime("%Y-%m-%d")
      }
    end
  end

  def search_by_cuisine_and_grade(cuisine, grade)
    Builders::Restaurants::ByCuisineAndMinGradeBuilder.build(cuisine, grade)
  end
end
