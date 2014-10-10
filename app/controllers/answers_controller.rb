class AnswersController < ApplicationController

  # def new
  #   @answer = Answer.new
  # end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params) 
  end

  # def edit
  # end

  def update
    @answer = Answer.find(params[:id])
    @answer.update(answer_params)
    @question = @answer.question
  end

  # def destroy
  #   @answer.destroy
  #   flash[:notice] = "Answer with id:#{@answer.id} destroy!"
  #   redirect_to @answer.question
  # end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
