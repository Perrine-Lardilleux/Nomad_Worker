class CreateCities < ActiveRecord::Migration[6.0]
  def change
    create_table :cities do |t|
      t.string :name
      t.string :coordinates
      t.float :temperature
      t.jsonb :data
      t.references :country, null: false, foreign_key: true

      t.timestamps
    end
  end
end
