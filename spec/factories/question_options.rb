FactoryBot.define do
  factory :question_option do
    question { create(:question) }
    option { Faker::Lorem.word }
  end
end
