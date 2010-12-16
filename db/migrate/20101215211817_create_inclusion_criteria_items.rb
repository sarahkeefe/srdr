class CreateInclusionCriteriaItems < ActiveRecord::Migration
  def self.up
    create_table :inclusion_criteria_items do |t|
      t.integer :study_id
      t.string :item_text

      t.timestamps
    end
  end

  def self.down
    drop_table :inclusion_criteria_items
  end
end
