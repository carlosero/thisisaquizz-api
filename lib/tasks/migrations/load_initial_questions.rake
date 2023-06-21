namespace :migrations do

  desc 'Loads the initial questions to be used in questionnaires'
  task load_initial_questions: :environment do

    questions = [
      {
        number: 1,
        question: 'Which is the largest country in the world by population?',
        options: ['India', 'USA', 'China', 'Russia'],
        correct_answer: 'China'
      },
      {
        number: 2,
        question: 'When did the second world war end?',
        options: ['1945', '1939', '1944', '1942'],
        correct_answer: '1945'
      },
      {
        number: 3,
        question: 'Which was the first country to issue paper currency?',
        options: ['USA', 'France', 'Italy', 'China'],
        correct_answer: 'China'
      },
      {
        number: 4,
        question: 'Which city hosted the 1996 Summer Olympics?',
        options: ['Atlanta', 'Sydney', 'Athens', 'Beijing'],
        correct_answer: 'Atlanta'
      },
      {
        number: 5,
        question: 'Who invented the telephone?',
        options: ['Albert Einstein', 'Alexander Graham Bell', 'Isaac Newton', 'Marie Curie',],
        correct_answer: 'Alexander Graham Bell'
      }
    ]

    # upsert (create or update) questions
    questions.each do |question_data|
      # question data
      question = Question.find_or_initialize_by(number: question_data[:number])
      question.question = question_data[:question]
      question.correct_answer = question_data[:correct_answer]

      # question options
      QuestionOption.where(question_id: question.id).destroy_all
      question_data[:options].each do |option|
        question.question_options.build(option: option)
      end

      question.save!
    end
  end
end
