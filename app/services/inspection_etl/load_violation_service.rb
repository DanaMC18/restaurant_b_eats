# Finds or creates a Violation
class InspectionEtl::LoadViolationService

  def self.load(attributes)
    Violation.where(attributes).first_or_create!
  end

end
