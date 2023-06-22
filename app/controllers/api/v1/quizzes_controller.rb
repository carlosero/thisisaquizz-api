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
      # if the user is answering but sending a response to the wrong question,
      # return error, it might be loading on the frontend
      if @quiz.current_question != params[:question_number].to_i
        return render(status: :unprocessable_entity)
      end

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
