class CreateStudyBaselineCharacteristicFields < ActiveRecord::Migration
  def self.up
    create_table :study_baseline_characteristic_fields do |t|
      t.integer :study_id
      t.integer :baseline_characteristic_field_id
      t.integer :display_number

      t.timestamps
    end
  end

  def self.down
    drop_table :study_baseline_characteristic_fields
  end
end
