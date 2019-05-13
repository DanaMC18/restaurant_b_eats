# Read CSV file to transform each row and create data; optional row_count for testing
class InspectionEtl::ExtractorService

  def self.import(filepath, row_count = nil)
    new(filepath, row_count).import
  end

  def initialize(filepath, row_count = nil)
    @inspections = CSV.read(filepath, headers: true)
    @row_count   = row_count
  end

  def import
    num_of_rows_to_extract = @row_count.to_i || @inspections.rows.count

    @inspections.first(num_of_rows_to_extract).each do |inspection|
      InspectionEtl::TransformerService.transform(inspection.to_hash)
    end
  end
end
