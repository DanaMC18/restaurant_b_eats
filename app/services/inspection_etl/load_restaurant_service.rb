class InspectionEtl::LoadRestaurantService

  def self.load(attributes)
    new(attributes).find_or_create_restaurant
  end

  def initialize(attributes)
    @attributes = attributes
  end

  def find_or_create_restaurant
    attributes[:cuisine] = find_or_create_cuisine(attributes[:cuisine])

    Restaurant.where(attributes).first_or_create
  end

  private

  attr_reader :attributes

  def find_or_create_cuisine
    Cuisine.where(description: attributes[:cuisine]).first_or_create
  end

end
