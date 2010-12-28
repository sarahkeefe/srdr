class AddFieldsToCategories < ActiveRecord::Migration
  def self.up
  add_column :population_characteristics, :measurement_type, :string
  end

  def self.down
  remove_column :population_characteristics, :measurement_type  
  end
end
