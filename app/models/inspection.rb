class Inspection < ActiveRecord::Base
  belongs_to :inspection_type
  belongs_to :restuarant
  has_and_belongs_to_many :violations
  validates_presence_of :inspection_type_id, :restaurant_id, :inspection_date, :record_date
end
