class Api::V1::QuizzesController < ApplicationController

  def show
    @quiz = Quiz.find_by_id(params[:id])

    if @quiz
      render json: @quiz.to_api_json
    else
      render status: :not_found
    end
  end

  def create
    @quiz = Quiz.create(state: 'in_progress', current_question: 1)

    render json: @quiz.to_api_json
  end
end
