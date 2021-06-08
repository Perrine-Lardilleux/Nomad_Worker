class AddLongitudeToCities < ActiveRecord::Migration[6.0]
  def change
    add_column :cities, :longitude, :float
  end
end
