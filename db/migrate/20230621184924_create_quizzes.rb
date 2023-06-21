class CreateQuizzes < ActiveRecord::Migration[7.0]
  def change
    create_table :quizzes do |t|
      t.string :state
      t.integer :current_question
      t.integer :final_score

      t.timestamps
    end
  end
end
