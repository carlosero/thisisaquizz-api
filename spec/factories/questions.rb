FactoryBot.define do
  factory :question do
    transient do
      with_questions { true }
    end

    number { (1..15).to_a.sample }
    question { Faker::Lorem.sentence }
    correct_answer { Faker::Lorem.word }

    after(:create) do |question, evaluator|
      if evaluator.with_questions
        create_list(:question_option, 3, question: question)
        create(:question, question: question, option: question.correct_answer)
      end
    end
  end
end
