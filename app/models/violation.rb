class Violation < ActiveRecord::Base
  has_and_belongs_to_many :inspections

  validates_presence_of :code, :description
  validates_inclusion_of :is_critical, in: [true, false]
  validates_length_of :code, maximum: 3

  scope :critical,      -> { where(is_critical: true) }
  scope :not_critical,  -> { where(is_critical: false) }

  def critical?
    is_critical
  end
end
