class AddCityTypeToCities < ActiveRecord::Migration[6.0]
  def change
    add_column :cities, :city_type, :string
  end
end
