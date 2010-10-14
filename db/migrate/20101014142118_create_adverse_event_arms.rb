class CreateAdverseEventArms < ActiveRecord::Migration
  def self.up
    create_table :adverse_event_arms do |t|
      t.integer :study_id
      t.integer :adverse_event_id
      t.integer :arm_id
      t.integer :num_affected
      t.integer :num_at_risk

      t.timestamps
    end
  end

  def self.down
    drop_table :adverse_event_arms
  end
end
