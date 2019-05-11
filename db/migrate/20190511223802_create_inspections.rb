class CreateInspections < ActiveRecord::Migration[5.0]
  def change
    create_table :inspections do |t|
      t.references  :inspection_type, null: false
      t.references  :restaurant,      null: false
      t.integer     :score
      t.string      :grade,           limit: 1
      t.date        :grade_date
      t.date        :inspection_date, null: false
      t.date        :record_date,     null: false
      t.timestamps
    end

    add_index :inspections, :score,       where: "score IS NOT NULL"
    add_index :inspections, :grade,       where: "grade IS NOT NULL"
    add_index :inspections, :grade_date,  where: "grade_date IS NOT NULL"
  end
end
