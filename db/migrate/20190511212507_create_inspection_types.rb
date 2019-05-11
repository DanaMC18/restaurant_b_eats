class CreateInspectionTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :inspection_types do |t|
      t.string :description, null: false
      t.timestamps
    end
  end
end
