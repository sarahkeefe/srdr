class CreateQualityDimensionDataPoints < ActiveRecord::Migration
  def self.up
    create_table :quality_dimension_data_points do |t|
      t.integer :quality_dimension_field_id
      t.string :value
      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :quality_dimension_data_points
  end
end
