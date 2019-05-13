class Inspection < ActiveRecord::Base
  belongs_to :inspection_type
  belongs_to :restuarant, optional: true
  has_and_belongs_to_many :violations
  validates_presence_of :inspection_date, :record_date
end
