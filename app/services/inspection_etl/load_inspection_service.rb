# Finds or creates an InspectionType; creates Inspection; returns Inspection
class InspectionEtl::LoadInspectionService

  def self.load(attributes)
    new(attributes).create_inspection
  end

  def initialize(attributes)
    @attributes = attributes
  end

  def create_inspection
    handle_not_yet_graded
    attributes[:inspection_type] = find_or_create_inspection_type
    Inspection.where(attributes.except(:inspection_desc)).first_or_create
  end

  private

  attr_reader :attributes

  def find_or_create_inspection_type
    InspectionType.where(description: attributes[:inspection_desc]).first_or_create
  end

  def handle_not_yet_graded
    return nil if attributes[:grade].try(:downcase) == "not yet graded"
  end

end
