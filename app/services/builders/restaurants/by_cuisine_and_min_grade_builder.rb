# Uses ActiveRecord and Arel to create the following SQL query:
# SELECT restaurants.*
# FROM restaurants
#   INNER JOIN cuisines ON cuisines.id = restaurants.cuisine_id
# WHERE cuisine.description = %<cuisine_desc>%
#   AND restaurants.current_grade IN (<grades_greater_than_or_equal_to_grade>)
class Builders::Restaurants::ByCuisineAndMinGradeBuilder

  attr_reader :cuisine_desc, :grade

  def self.build(cuisine, grade)
    new(cuisine, grade).search
  end

  def initialize(cuisine, grade)
    @cuisine_desc = cuisine || ""
    @grade        = grade
  end

  def search
    Restaurant.joins(:cuisine)
              .where(cuisines_table[:description].matches("%#{cuisine_desc}%")
                .and(restaurants_table[:current_grade].in(grades_greater_than_or_equal)))
  end

  private

  def grades_greater_than_or_equal
    return valid_grades if grade.nil?

    index = valid_grades.find_index(grade.upcase)
    valid_grades.first(index + 1)
  end

  def valid_grades
    Inspection::VALID_GRADES
  end

  # DEFINE TABLES #

  def cuisines_table
    Cuisine.arel_table
  end

  def restaurants_table
    Restaurant.arel_table
  end
end
