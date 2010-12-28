class CreateBaselineCharacteristicFields < ActiveRecord::Migration
  def self.up
    create_table :baseline_characteristic_fields do |t|
      t.string :category_title
      t.string :units
      t.string :measurement_type
      t.boolean :force_measurements
      t.boolean :display_arms
      t.boolean :display_total
      t.text :field_notes

      t.timestamps
    end
  end

  def self.down
    drop_table :baseline_characteristic_fields
  end
end
