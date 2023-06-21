FactoryBot.define do
  factory :question_answer do
    quiz { create(:quiz) }
    question { create(:question) }
    answer { Faker::Lorem.word }
    score { 0 }
  end
end
