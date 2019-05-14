describe InspectionEtl::TransformerService do
  describe ".transform" do
    it "parses hash of raw CSV data into groups of class attributes in order to load new data" do
      restaurant      = create(:restaurant)
      inspection      = create(:inspection, restaurant_id: restaurant.id)
      violation       = create(:violation)
      raw_inspection  = {
        "CAMIS"                 => restaurant.camis,
        "DBA"                   => restaurant.dba,
        "CUISINE DESCRIPTION"   => restaurant.cuisine.description,
        "BUILDING"              => restaurant.building_number,
        "STREET"                => restaurant.street,
        "BORO"                  => restaurant.boro,
        "ZIPCODE"               => restaurant.zipcode.to_s,
        "PHONE"                 => restaurant.phone_number.to_s,
        "INSPECTION DATE"       => inspection.inspection_date.strftime("%m/%d/%Y"),
        "VIOLATION CODE"        => violation.code,
        "VIOLATION DESCRIPTION" => violation.description,
        "CRITICAL FLAG"         => "NOT CRITICAL",
        "SCORE"                 => inspection.score.to_s,
        "GRADE"                 => inspection.grade,
        "GRADE DATE"            => inspection.grade_date.strftime("%m/%d/%Y"),
        "RECORD DATE"           => inspection.record_date.strftime("%m/%d/%Y"),
        "INSPECTION TYPE"       => inspection.inspection_type.description
      }

      expect(InspectionEtl::LoadInspectionService).to receive(:load).and_return(inspection)
      expect(InspectionEtl::LoadRestaurantService).to receive(:load).and_return(restaurant)
      expect(InspectionEtl::LoadViolationService).to receive(:load).and_return(violation)
      InspectionEtl::TransformerService.transform(raw_inspection)
      expect(inspection.violations.count > 0).to be true
    end

    context "violation data is not present in hash" do
      it "does not associate the newly created inspection to a violation" do
        restaurant      = create(:restaurant)
        inspection      = create(:inspection, restaurant_id: restaurant.id)
        raw_inspection  = {
          "CAMIS"                 => restaurant.camis,
          "DBA"                   => restaurant.dba,
          "CUISINE DESCRIPTION"   => restaurant.cuisine.description,
          "BUILDING"              => restaurant.building_number,
          "STREET"                => restaurant.street,
          "BORO"                  => restaurant.boro,
          "ZIPCODE"               => restaurant.zipcode.to_s,
          "PHONE"                 => restaurant.phone_number.to_s,
          "INSPECTION DATE"       => inspection.inspection_date.strftime("%m/%d/%Y"),
          "VIOLATION CODE"        => "",
          "VIOLATION DESCRIPTION" => "",
          "CRITICAL FLAG"         => "",
          "SCORE"                 => inspection.score.to_s,
          "GRADE"                 => inspection.grade,
          "GRADE DATE"            => inspection.grade_date.strftime("%m/%d/%Y"),
          "RECORD DATE"           => inspection.record_date.strftime("%m/%d/%Y"),
          "INSPECTION TYPE"       => inspection.inspection_type.description
        }

        allow(InspectionEtl::LoadInspectionService).to receive(:load).and_return(inspection)
        allow(InspectionEtl::LoadRestaurantService).to receive(:load).and_return(restaurant)

        expect(InspectionEtl::LoadViolationService).not_to receive(:load)
        InspectionEtl::TransformerService.transform(raw_inspection)
        expect(inspection.violations.count).to be 0
      end
    end
  end
end
