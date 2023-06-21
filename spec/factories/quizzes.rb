FactoryBot.define do
  factory :quiz do
    state { 'in_progress' }
    current_question { 1 }
    final_score { 0 }
  end
end
