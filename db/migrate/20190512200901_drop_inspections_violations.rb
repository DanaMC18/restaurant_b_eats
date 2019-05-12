class DropInspectionsViolations < ActiveRecord::Migration[5.0]
  def change
    drop_table :inspections_violations
  end
end
