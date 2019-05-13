# Finds or creates Cuisine; finds or creates Restaurant; returns Restaurant
class InspectionEtl::LoadRestaurantService

  def self.load(attributes)
    new(attributes).find_or_create_restaurant
  end

  def initialize(attributes)
    @attributes = attributes
  end

  def find_or_create_restaurant
    attributes[:cuisine] = find_or_create_cuisine

    Restaurant.where(attributes.except(:cuisine_desc)).first_or_create!
  end

  private

  attr_reader :attributes

  def find_or_create_cuisine
    Cuisine.where(description: attributes[:cuisine_desc]).first_or_create
  end

end
