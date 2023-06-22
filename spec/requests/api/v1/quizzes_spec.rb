require 'rails_helper'

RSpec.describe 'Quizzes API', type: :request do

  describe 'POST /quizzes' do
    let!(:question_1) { create(:question, number: 1) }

    it 'creates a new quiz and returns the first question' do
      post '/api/v1/quizzes'

      expect(response).to have_http_status(:success)

      json = JSON.parse(response.body)

      expect(json['state']).to eq('in_progress')
      expect(json['question']['number']).to eq(1)
      expect(json['question']['question']).to eq(question_1.question)
      expect(json['question']['options']).to eq(question_1.question_options.pluck(:option))
    end
  end

  describe 'GET /quizzes/:id' do

    it 'returns 404 when the quiz is not found' do
      quiz = create(:quiz, current_question: 2, state: :in_progress)

      get "/api/v1/quizzes/#{quiz.id+1}"

      expect(response).to have_http_status(:not_found)
    end

    context 'when quiz is in_progress' do
      let!(:quiz) { create(:quiz, current_question: 2, state: :in_progress) }
      let!(:question_2) { create(:question, number: 2) }

      it 'returns the current quiz with its current question' do
        get "/api/v1/quizzes/#{quiz.id}"

        expect(response).to have_http_status(:success)

        json = JSON.parse(response.body)

        expect(json['state']).to eq('in_progress')
        expect(json['question']['number']).to eq(2)
        expect(json['question']['question']).to eq(question_2.question)
        expect(json['question']['options']).to eq(question_2.question_options.pluck(:option))
      end
    end

    context 'when quiz is completed' do
      let!(:quiz) { create(:quiz, state: :completed, final_score: 3) }

      it 'returns the current quiz with its score' do
        get "/api/v1/quizzes/#{quiz.id}"

        expect(response).to have_http_status(:success)

        json = JSON.parse(response.body)

        expect(json['state']).to eq('completed')
        expect(json['score']).to eq(3)
      end
    end
  end

  describe 'POST /quizzes/:id/next' do

    context 'when the quiz has more questions' do
      let!(:quiz) { create(:quiz, current_question: 2, state: :in_progress) }
      let!(:question_2) { create(:question, number: 2) }
      let!(:question_3) { create(:question, number: 3) }

      context 'when there is an answer' do

        it 'returns quiz in_progress and the next question of the quiz' do
          post "/api/v1/quizzes/#{quiz.id}/next", params: { answer: question_3.correct_answer, question_number: 2 }

          expect(response).to have_http_status(:success)

          json = JSON.parse(response.body)

          expect(json['state']).to eq('in_progress')
          expect(json['question']['number']).to eq(3)
          expect(json['question']['question']).to eq(question_3.question)
          expect(json['question']['options']).to eq(question_3.question_options.pluck(:option))
        end

        it 'returns error 422 if the question_number response is not the current question' do
          post "/api/v1/quizzes/#{quiz.id}/next", params: { answer: question_3.correct_answer, question_number: 4 }

          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'when there is no answer' do
        it 'returns quiz in_progress and the next question of the quiz' do
          post "/api/v1/quizzes/#{quiz.id}/next"

          expect(response).to have_http_status(:success)

          json = JSON.parse(response.body)

          expect(json['state']).to eq('in_progress')
          expect(json['question']['number']).to eq(3)
          expect(json['question']['question']).to eq(question_3.question)
          expect(json['question']['options']).to eq(question_3.question_options.pluck(:option))
        end
      end
    end

    context 'when the quiz is in the last question' do
      let!(:quiz) { create(:quiz, current_question: 5, state: :in_progress) }
      let!(:question_5) { create(:question, number: 5) }

      context 'when there is an answer' do

        it 'returns question completed and the score of the quiz' do
          post "/api/v1/quizzes/#{quiz.id}/next", params: { answer: question_5.correct_answer, question_number: 5 }

          expect(response).to have_http_status(:success)

          json = JSON.parse(response.body)

          expect(json['state']).to eq('completed')
          expect(json['score']).to eq(1) # question 5
        end
      end

      context 'when there is no answer' do

        it 'returns question completed and the score of the quiz' do
          post "/api/v1/quizzes/#{quiz.id}/next"

          expect(response).to have_http_status(:success)

          json = JSON.parse(response.body)

          expect(json['state']).to eq('completed')
          expect(json['score']).to eq(0) # no right questions
        end
      end
    end
  end
end
