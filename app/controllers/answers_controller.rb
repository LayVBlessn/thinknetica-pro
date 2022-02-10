class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question

  def create
    @answer = @question.answers.new(answer_params)
    current_user.answers << @answer
    if @answer.save
      redirect_to question_path(@question), notice: 'Answer successfully aded!'
    else
      render 'questions/show'
    end
  end

  def destroy
    @answer = Answer.find(params[:id])

    if @answer.user == current_user
      @answer.destroy
      redirect_to question_path(@question), notice: 'Answer was successfully deleted'
    else
      redirect_to question_path(@question), notice: 'Only Author can delete this Answer'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def find_question
    @question = Question.find(params[:question_id])
  end
end
