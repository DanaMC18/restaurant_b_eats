# Read CSV file to transform each row and create data
class InspectionEtl::ExtractorService
  attr_reader :inspections

  def self.import(filepath)
    new(filepath).import
  end

  def initialize(filepath)
    @inspections = CSV.read(filepath, headers: true)
  end

  def import
    @inspections.each do |inspection|
      InspectionEtl::TransformerService.transform(inspection.to_hash)
    end
  end
end
