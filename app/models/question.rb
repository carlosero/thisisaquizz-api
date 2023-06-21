class Question < ApplicationRecord
  has_many :question_options

  def score(answer)
    answer == correct_answer ? 1 : 0
  end
end
