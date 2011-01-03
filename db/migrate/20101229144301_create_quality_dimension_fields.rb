class CreateQualityDimensionFields < ActiveRecord::Migration
  def self.up
    create_table :quality_dimension_fields do |t|
      t.string :title
      t.text :field_notes
      t.integer :template_id
      t.integer :study_id

      t.timestamps
    end
  end

  def self.down
    drop_table :quality_dimension_fields
  end
end
