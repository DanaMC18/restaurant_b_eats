class Inspection < ActiveRecord::Base

  VALID_GRADES = %w[A B C]

  belongs_to :inspection_type
  belongs_to :restuarant, optional: true
  has_and_belongs_to_many :violations
  validates_presence_of :inspection_date, :record_date
end
