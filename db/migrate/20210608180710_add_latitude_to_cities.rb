class AddLatitudeToCities < ActiveRecord::Migration[6.0]
  def change
    add_column :cities, :latitude, :float
  end
end
