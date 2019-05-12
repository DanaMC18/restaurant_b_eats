class InspectionEtl::LoadViolationService
  def self.load(attributes)
    return nil unless attributes[:code].present?

    Violation.where(attributes).first_or_create
  end
end
