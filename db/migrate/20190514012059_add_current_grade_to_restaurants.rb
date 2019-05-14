class AddCurrentGradeToRestaurants < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :current_grade, :string
    add_column :restaurants, :current_grade_date, :date

    add_index :restaurants, :current_grade
    add_index :restaurants, :current_grade_date
  end
end
