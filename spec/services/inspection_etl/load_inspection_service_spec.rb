describe InspectionEtl::LoadInspectionService do

  describe ".load" do
    context "attributes do not match an existing inspection" do
      it "creates a new inspection" do
        restaurant      = create(:restaurant)
        inspection_type = create(:inspection_type)
        one_month_ago   = Date.today - 1.month
        attributes = {
          restaurant_id:      restaurant.id,
          inspection_desc:    inspection_type.description,
          score:              18,
          grade:              "B",
          grade_date:         one_month_ago,
          inspection_date:    one_month_ago,
          record_date:        Date.today
        }

        expect(Inspection.exists?(attributes.except(:inspection_desc))).to be false
        InspectionEtl::LoadInspectionService.load(attributes)
        expect(Inspection.exists?(attributes.except(:inspection_desc))).to be true
        expect(Inspection.where(attributes.except(:inspection_desc)).first.inspection_type)
          .to eq inspection_type
      end
    end

    context "attributes match an existing inspection" do
      it "returns the existing inspection" do
        inspection = create(:inspection)
        attributes = {
          restaurant_id:      inspection.restaurant_id,
          inspection_desc:    inspection.inspection_type.description,
          score:              inspection.score,
          grade:              inspection.grade,
          grade_date:         inspection.grade_date,
          inspection_date:    inspection.inspection_date,
          record_date:        inspection.record_date
        }

        expect(Inspection.exists?(attributes.except(:inspection_desc))).to be true
        expect(InspectionEtl::LoadInspectionService.load(attributes))
          .to eq inspection
      end
    end
  end

  describe "#find_or_create_inspection_type" do
    context "inspection_desc in attributes does not match an existing inspection_type" do
      it "creates a new inspection_type" do
        attributes  = { inspection_desc: "just because" }
        service     = InspectionEtl::LoadInspectionService.new(attributes)

        expect(InspectionType.exists?(description: attributes[:inspection_desc]))
          .to be false
        service.send(:find_or_create_inspection_type)
        expect(InspectionType.exists?(description: attributes[:inspection_desc]))
          .to be true
      end
    end

    context "inspection_desc in attributes matches an existing inspection_type" do
      it "returns the exisint inspection_type" do
        inspection_type = create(:inspection_type)
        attributes      = { inspection_desc: inspection_type.description }
        service         = InspectionEtl::LoadInspectionService.new(attributes)

        expect(service.send(:find_or_create_inspection_type)).to eq inspection_type
      end
    end
  end
end
