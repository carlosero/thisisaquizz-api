# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_06_21_185006) do
  create_table "question_options", force: :cascade do |t|
    t.integer "question_id", null: false
    t.string "option"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_question_options_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.integer "number"
    t.string "question"
    t.string "correct_answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quiz_answers", force: :cascade do |t|
    t.integer "quiz_id", null: false
    t.integer "question_id", null: false
    t.string "answer"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_quiz_answers_on_question_id"
    t.index ["quiz_id"], name: "index_quiz_answers_on_quiz_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.string "state"
    t.integer "current_question"
    t.integer "final_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "question_options", "questions"
  add_foreign_key "quiz_answers", "questions"
  add_foreign_key "quiz_answers", "quizzes"
end
