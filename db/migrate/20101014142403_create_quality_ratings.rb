class CreateQualityRatings < ActiveRecord::Migration
  def self.up
    create_table :quality_ratings do |t|
      t.integer :study_id
      t.string :guideline_used
      t.string :current_overall_rating

      t.timestamps
    end
  end

  def self.down
    drop_table :quality_ratings
  end
end
