class Cuisine < ActiveRecord::Base
  has_many :restaurants
  validates_presence_of :description
end
