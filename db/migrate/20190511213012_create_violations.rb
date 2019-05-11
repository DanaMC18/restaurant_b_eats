class CreateViolations < ActiveRecord::Migration[5.0]
  def change
    create_table :violations do |t|
      t.string  :code,        null: false,  limit: 3
      t.string  :description, null: false
      t.boolean :is_critical, null: false,  default: false
      t.timestamps
    end

    add_index :violations, :code
    add_index :violations, :is_critical
  end
end
