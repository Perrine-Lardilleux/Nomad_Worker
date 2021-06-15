class AddOverallScoreToCities < ActiveRecord::Migration[6.0]
  def change
    add_column :cities, :overall_score, :float
  end
end
