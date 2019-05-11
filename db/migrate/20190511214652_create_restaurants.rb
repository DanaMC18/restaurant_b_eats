class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.integer     :camis,           null: false
      t.string      :dba,             null: false
      t.references  :cuisine,         null: false
      t.string      :building_number, null: false
      t.string      :street,          null: false
      t.string      :boro,            null: false
      t.integer     :zipcode,         null: false
      t.integer     :phone_number,    null: false
      t.timestamps
    end

    add_index :restaurants, :camis
    add_index :restaurants, :dba
  end
end
