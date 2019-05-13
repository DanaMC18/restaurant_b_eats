task import_inspections: :environment do
  filename  = "DOHMH_New_York_City_Restaurant_Inspection_Results.csv"
  filepath  = Rails.root.join("tmp", filename).to_s
  row_count = ENV["ROW_COUNT"] || nil

  InspectionEtl::ExtractorService.import(filepath, row_count)
end
