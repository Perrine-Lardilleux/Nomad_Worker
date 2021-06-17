class RemoveTemperatureFromCities < ActiveRecord::Migration[6.0]
  def change
    remove_column :cities, :temperature
  end
end
