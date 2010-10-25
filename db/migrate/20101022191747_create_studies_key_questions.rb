class CreateStudiesKeyQuestions < ActiveRecord::Migration
  def self.up
    create_table :studies_key_questions do |t|
      t.integer :study_id
      t.integer :key_question_id

      t.timestamps
    end
  end

  def self.down
    drop_table :studies_key_questions
  end
end
