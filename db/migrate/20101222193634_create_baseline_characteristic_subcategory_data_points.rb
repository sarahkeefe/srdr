class CreateBaselineCharacteristicSubcategoryDataPoints < ActiveRecord::Migration
  def self.up
    create_table :baseline_characteristic_subcategory_data_points do |t|
      t.integer :baseline_characteristic_subcategory_field_id
      t.integer :arm_id
      t.boolean :is_total
      t.string :value

      t.timestamps
    end
  end

  def self.down
    drop_table :baseline_characteristic_subcategory_data_points
  end
end
