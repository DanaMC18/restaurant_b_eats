class Builders::RestaurantQueries::SearchBuilder

  attr_reader :cuisine_desc, :grade

  def self.build(cuisine, grade)
    new(cuisine, grade).search
  end

  def initialize(cuisine, grade)
    @cuisine_desc = cuisine
    @grade        = grade
  end

  def search
    Restaurant.joins(:cuisine)
              .joins(:inspections)
              .where(cuisines_table[:description].matches("%#{cuisine_desc}%"))
              .where(inspections_table[:grade].in(grades))
  end

  private

  def grades
    index = Inspection::VALID_GRADES.index_of(grade.upcase)
    Inspection::VALID_GRADES.first(index + 1)
  end

  def cuisines_table
    Cuisine.arel_table
  end

  def inspections_table
    Inspections.arel_table
  end

  def restuarants_table
    Restaurant.arel_table
  end
end
