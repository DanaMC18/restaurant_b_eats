class Violation < ActiveRecord::Base
  validates_presence_of :code, :description, :is_critical
  validates_length_of :code, maximum: 3

  scope :critical,      -> { where(is_critical: true) }
  scope :not_critical,  -> { where(is_critical: false) }

  def critical?
    is_critical
  end
end
