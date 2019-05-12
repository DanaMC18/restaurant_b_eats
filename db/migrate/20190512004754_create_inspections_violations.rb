class CreateInspectionsViolations < ActiveRecord::Migration[5.0]
  def change
    create_table :inspections_violations do |t|
      t.references :inspection, null: false
      t.references :violations, null: false
      t.timestamps
    end
  end
end
