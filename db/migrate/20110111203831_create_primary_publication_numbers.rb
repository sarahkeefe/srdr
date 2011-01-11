class CreatePrimaryPublicationNumbers < ActiveRecord::Migration
  def self.up
    create_table :primary_publication_numbers do |t|
      t.integer :primary_publication_id
      t.string :number
      t.string :number_type

      t.timestamps
    end
  end

  def self.down
    drop_table :primary_publication_numbers
  end
end
