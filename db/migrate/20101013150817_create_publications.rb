class CreatePublications < ActiveRecord::Migration
  def self.up
    create_table :publications do |t|
      t.integer :study_id
      t.string :title
      t.string :author
      t.string :country
      t.string :year
      t.string :isbn
      t.string :ui
      t.string :ui_type
      t.boolean :is_primary

      t.timestamps
    end
  end

  def self.down
    drop_table :publications
  end
end
