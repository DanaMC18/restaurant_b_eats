class InspectionType < ActiveRecord::Base
  has_many :inspections
  validates_presence_of :description
end
