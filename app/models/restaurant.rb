class Restaurant < ActiveRecord::Base
  belongs_to :cuisine
  has_many :inspections

  validates_presence_of :camis, :cuisine_id, :dba, 
    :building_number, :street, :boro, :zipcode, :phone_number

  validates_inclusion_of :boro, in: %w[Brooklyn Bronx Manhattan Queens Staten\ Island]

  def city_address
    "#{building_number} #{street}, #{boro}, #{zipcode}"
  end

end
