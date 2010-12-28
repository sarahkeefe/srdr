class CreateStudyTemplates < ActiveRecord::Migration
  def self.up
    create_table :study_templates do |t|
      t.integer :study_id
      t.integer :template_id

      t.timestamps
    end
  end

  def self.down
    drop_table :study_templates
  end
end
