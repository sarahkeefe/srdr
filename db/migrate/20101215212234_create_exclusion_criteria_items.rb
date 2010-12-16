class CreateExclusionCriteriaItems < ActiveRecord::Migration
  def self.up
    create_table :exclusion_criteria_items do |t|
      t.integer :study_id
      t.string :item_text

      t.timestamps
    end
  end

  def self.down
    drop_table :exclusion_criteria_items
  end
end
