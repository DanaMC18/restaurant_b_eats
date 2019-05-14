class Restaurant < ActiveRecord::Base
  belongs_to :cuisine
  has_many :inspections
  has_many :violations, through: :inspections

  validates_presence_of :camis, :cuisine_id, :dba,
    :building_number, :street, :boro, :zipcode, :phone_number

  validates_inclusion_of :boro,
    in: %w[Brooklyn Bronx Manhattan Queens Staten\ Island].map(&:upcase),
    allow_blank: true

  validates_length_of :camis, maximum: 8
  validates_length_of :phone_number, maximum: 10

  def city_address
    "#{building_number} #{street}, #{boro}, #{zipcode}"
  end

end
