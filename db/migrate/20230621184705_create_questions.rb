class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.integer :number
      t.string :question
      t.string :correct_answer

      t.timestamps
    end
  end
end
