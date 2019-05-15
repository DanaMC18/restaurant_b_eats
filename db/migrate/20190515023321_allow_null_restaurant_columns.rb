class AllowNullRestaurantColumns < ActiveRecord::Migration[5.0]
  def change
    change_column :restaurants, :building_number, :string, null: true
    change_column :restaurants, :street, :string, null: true
    change_column :restaurants, :boro, :string, null: true
    change_column :restaurants, :zipcode, :string, null: true
    change_column :restaurants, :phone_number, :string, null: true
  end
end
