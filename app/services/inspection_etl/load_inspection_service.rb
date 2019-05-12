class InspectionEtl::LoadInspectionService

  def self.load(attributes)
    new(attributes).create_inspection
  end

  def initialize(attributes)
    @attributes = attributes
  end

  def create_inspection
    attributes[:inspection_type] = find_or_create_inspection_type
    Inspection.create!(attributes)
  end

  private

  attr_reader :attributes

  def find_or_create_inspection_type
    InspectionType.where(description: attributes[:inspection_type]).first_or_create
  end

end
