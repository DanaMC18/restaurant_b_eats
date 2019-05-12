class RecreateInspectionsViolations < ActiveRecord::Migration[5.0]
  def change
    create_table :inspections_violations do |t|
      t.integer :inspection_id, null: false
      t.integer :violation_id, null: false
      t.timestamps
    end

    add_index :inspections_violations, :inspection_id
    add_index :inspections_violations, :violation_id
  end
end
