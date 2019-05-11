class Inspection < ActiveRecord::Base
  belongs_to :inspection_type
  belongs_to :restuarant
  validates_presence_of :inspection_type_id, :restaurant_id, :inspection_date, :record_date
end
