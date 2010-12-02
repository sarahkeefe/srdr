class CreatePublicationNumbers < ActiveRecord::Migration
  def self.up
    create_table :publication_numbers do |t|
      t.integer :publication_id
      t.string :number
      t.string :number_type

      t.timestamps
    end
  end

  def self.down
    drop_table :publication_numbers
  end
end
