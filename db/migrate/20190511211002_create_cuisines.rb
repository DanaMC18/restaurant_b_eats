class CreateCuisines < ActiveRecord::Migration[5.0]
  def change
    create_table :cuisines do |t|
      t.string :description, null: false
      t.timestamps
    end
  end
end
