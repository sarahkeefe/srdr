class CreateQualityAspects < ActiveRecord::Migration
  def self.up
    create_table :quality_aspects do |t|
      t.integer :study_id
      t.string :dimension
      t.string :value
      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :quality_aspects
  end
end
