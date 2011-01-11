class CreatePrimaryPublications < ActiveRecord::Migration
  def self.up
    create_table :primary_publications do |t|
      t.integer :study_id
      t.string :title
      t.string :author
      t.string :country
      t.string :year

      t.timestamps
    end
  end

  def self.down
    drop_table :primary_publications
  end
end
