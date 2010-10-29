class AddTotalsToPopcharData < ActiveRecord::Migration
  def self.up
	add_column :population_characteristic_data_points, :is_total, :boolean
  end

  def self.down
	remove_column :population_characteristic_data_points, :is_total
  end
end
