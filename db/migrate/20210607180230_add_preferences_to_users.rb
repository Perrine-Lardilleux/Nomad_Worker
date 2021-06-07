class AddPreferencesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :preferences, :jsonb
  end
end
