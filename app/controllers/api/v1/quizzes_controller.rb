class Api::V1::QuizzesController < ApplicationController

  def show
    @quiz = Quiz.find_by_id(params[:id])
    return render(status: :not_found) unless @quiz

    render json: @quiz.to_api_json
  end

  def next
    @quiz = Quiz.find_by_id(params[:id])
    return render(status: :not_found) unless @quiz

    if params[:answer]
      question = Question.find_by(number: @quiz.current_question)
      QuizAnswer.create(quiz: @quiz, question: question, answer: params[:answer], score: question.score(params[:answer]))
    end

    if @quiz.current_question == Quiz::LAST_QUESTION
      @quiz.update(state: 'completed', final_score: @quiz.quiz_answers.sum(:score))
    else
      @quiz.update(current_question: @quiz.current_question + 1)
    end

    render json: @quiz.to_api_json
  end

  def create
    @quiz = Quiz.create(state: 'in_progress', current_question: 1)

    render json: @quiz.to_api_json
  end
end
