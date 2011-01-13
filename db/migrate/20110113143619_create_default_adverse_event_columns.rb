class CreateDefaultAdverseEventColumns < ActiveRecord::Migration
  def self.up
    create_table :default_adverse_event_columns do |t|
      t.string :header
      t.string :name
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :default_adverse_event_columns
  end
end
