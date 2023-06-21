class Quiz < ApplicationRecord
  has_many :quiz_answers

  VALID_STATES = ['in_progress', 'completed'].freeze

  enum state: VALID_STATES.zip(VALID_STATES).to_h

  def to_api_json
    question = Question.find_by(number: current_question)

    {
      id: id,
      state: state,
      question: {
        number: question.number,
        question: question.question,
        options: question.question_options.pluck(:option)
      }
    }
  end
end
