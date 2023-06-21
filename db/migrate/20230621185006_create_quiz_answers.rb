class CreateQuizAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :quiz_answers do |t|
      t.references :quiz, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.string :answer
      t.integer :score

      t.timestamps
    end
  end
end
