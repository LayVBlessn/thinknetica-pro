# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_answer, only: %i[update destroy]

  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.create(answer_params.merge(user: current_user, question: @question))
  end

  def update
    @answer.update(answer_params)
    @question = @answer.question
  end

  def destroy
    if current_user.author_of?(@answer)
      @answer.question.update(best_answer_id: nil)
      @answer.destroy
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body, files: [], links_attributes: %i[name url id _destroy])
  end

  def find_answer
    @answer = Answer.with_attached_files.find(params[:id])
  end
end
