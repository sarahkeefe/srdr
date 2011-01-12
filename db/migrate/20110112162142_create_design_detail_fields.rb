class CreateDesignDetailFields < ActiveRecord::Migration
  def self.up
    create_table :design_detail_fields do |t|
      t.string :title
      t.text :field_notes
      t.integer :template_id
      t.integer :study_id

      t.timestamps
    end
  end

  def self.down
    drop_table :design_detail_fields
  end
end
