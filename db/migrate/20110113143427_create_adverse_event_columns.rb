class CreateAdverseEventColumns < ActiveRecord::Migration
  def self.up
    create_table :adverse_event_columns do |t|
      t.string :header
      t.string :name
      t.string :description
      t.integer :template_id
      t.integer :study_id

      t.timestamps
    end
  end

  def self.down
    drop_table :adverse_event_columns
  end
end
