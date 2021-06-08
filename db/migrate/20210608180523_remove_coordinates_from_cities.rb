class RemoveCoordinatesFromCities < ActiveRecord::Migration[6.0]
  def change
    remove_column :cities, :coordinates, :string
  end
end
