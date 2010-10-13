class CreateKeyQuestions < ActiveRecord::Migration
  def self.up
    create_table :key_questions do |t|
      t.integer :project_id
      t.integer :question_number
      t.string :question
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :key_questions
  end
end
