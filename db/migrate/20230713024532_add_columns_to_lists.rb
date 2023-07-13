class AddColumnsToLists < ActiveRecord::Migration[6.1]
  def change
    add_column :lists, :latitude, :float
    add_column :lists, :longitude, :float
  end
end
