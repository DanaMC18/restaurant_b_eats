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
end
