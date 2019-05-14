class Inspection < ActiveRecord::Base

  VALID_GRADES = %w[A B C].freeze

  belongs_to :inspection_type
  belongs_to :restaurant
  has_and_belongs_to_many :violations
  validates_presence_of :inspection_date, :record_date

  after_save :update_restaurant_current_grade, if: :grade?

  def grade?
    grade.present?
  end

  def update_restaurant_current_grade
    return unless restaurant.current_grade && restaurant.current_grade_date >= grade_date

    restaurant.update_attributes(current_grade: grade, current_grade_date: grade_date)
  end
end
