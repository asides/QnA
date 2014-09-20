class AnswersController < ApplicationController
  before_action :set_question, only: [:new, :create]
  before_action :set_answer, only: [:edit, :update, :destroy]

  def new
    @answer = Answer.new
  end

  def create
    @answer = Answer.new(answer_params.merge({question: @question}))

    if @answer.save
      redirect_to @question
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @answer.update(answer_params)
      redirect_to @answer.question
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy
    flash[:notice] = "Answer with id:#{@answer.id} destroy!"
    redirect_to @answer.question
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
