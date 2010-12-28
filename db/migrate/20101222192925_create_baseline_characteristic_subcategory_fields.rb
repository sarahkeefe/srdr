class CreateBaselineCharacteristicSubcategoryFields < ActiveRecord::Migration
  def self.up
    create_table :baseline_characteristic_subcategory_fields do |t|
      t.string :subcategory_title
      t.integer :baseline_characteristic_field_id

      t.timestamps
    end
  end

  def self.down
    drop_table :baseline_characteristic_subcategory_fields
  end
end
