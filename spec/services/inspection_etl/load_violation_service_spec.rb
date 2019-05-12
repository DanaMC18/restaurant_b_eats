describe InspectionEtl::LoadViolationService do
  context "attributes do not match an existing violation" do
    it "creates a new violation" do
      attributes = {
        code:         "12A",
        description:  "What was that smell?",
        is_critical:  true
      }

      expect(Violation.exists?(attributes)).to be false
      InspectionEtl::LoadViolationService.load(attributes)
      expect(Violation.exists?(attributes)).to be true
    end
  end

  context "attributes match an existing violation" do
    it "returns the existing violation" do
      violation   = create(:violation)
      attributes  = {
        code:         violation.code,
        description:  violation.description,
        is_critical:  violation.is_critical
      }

      expect(Violation.exists?(attributes)).to be true
      expect(InspectionEtl::LoadViolationService.load(attributes)).to eq violation
    end
  end
end
