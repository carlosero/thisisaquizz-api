class CreateQuestionOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :question_options do |t|
      t.references :question, null: false, foreign_key: true
      t.string :option

      t.timestamps
    end
  end
end
