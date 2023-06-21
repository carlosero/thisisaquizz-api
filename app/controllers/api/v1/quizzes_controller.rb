class Api::V1::QuizzesController < ApplicationController

  def create
    @quiz = Quiz.create(state: 'in_progress', current_question: 1)

    render json: @quiz.to_api_json
  end
end
