class ChangeRestaurantColumnTypes < ActiveRecord::Migration[5.0]
  def change
    change_column :restaurants, :camis,         :string
    change_column :restaurants, :zipcode,       :string
    change_column :restaurants, :phone_number,  :string
  end
end
