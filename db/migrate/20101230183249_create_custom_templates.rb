class CreateCustomTemplates < ActiveRecord::Migration
  def self.up
    create_table :custom_templates do |t|
      t.string :title
      t.integer :creator_id

      t.timestamps
    end
  end

  def self.down
    drop_table :custom_templates
  end
end
