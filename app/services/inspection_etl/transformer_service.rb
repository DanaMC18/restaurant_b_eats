# Parses CSV row (expected as a hash) into groups of attributes; creates data
class InspectionEtl::TransformerService

  def self.transform(inspection)
    new(inspection).transform
  end

  def initialize(inspection)
    @inspection = inspection
  end

  def transform
    new_inspection = InspectionEtl::LoadInspectionService.load(inspection_attributes)

    if new_inspection && violation_exists?
      new_inspection.violations << violation
      new_inspection.save
    end
  end

  private

  attr_reader :inspection

  def inspection_attributes
    {
      restaurant_id:      restaurant.id,
      inspection_desc:    inspection["INSPECTION TYPE"],
      score:              inspection["SCORE"].to_i.nonzero?,
      grade:              inspection["GRADE"].presence,
      grade_date:         inspection["GRADE DATE"].try(:to_date),
      inspection_date:    inspection["INSPECTION DATE"].to_date,
      record_date:        inspection["RECORD DATE"].to_date
    }
  end

  def restaurant
    @restaurant ||= InspectionEtl::LoadRestaurantService.load(restaurant_attributes)
  end

  def restaurant_attributes
    {
      camis:            inspection["CAMIS"],
      dba:              inspection["DBA"],
      cuisine_desc:     inspection["CUISINE DESCRIPTION"],
      building_number:  inspection["BUILDING"],
      street:           inspection["STREET"],
      boro:             inspection["BORO"],
      zipcode:          inspection["ZIPCODE"],
      phone_number:     inspection["PHONE"]
    }
  end

  def violation_exists?
    violation_attributes.values.all?(&:present?)
  end

  def violation
    @violation ||= InspectionEtl::LoadViolationService.load(violation_attributes)
  end

  def violation_attributes
    {
      code:         inspection["VIOLATION CODE"],
      description:  inspection["VIOLATION DESCRIPTION"],
      is_critical:  inspection["CRITICAL FLAG"]
    }
  end
end
