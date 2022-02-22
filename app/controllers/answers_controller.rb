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
      @answer.destroy
      redirect_to question_path(@answer.question), notice: 'Answer was successfully deleted'
    else
      redirect_to question_path(@answer.question), notice: 'Only Author can delete this Answer'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end
end
