class AnswersController < ApplicationController

  before_action :authenticate_user!

  before_action :load_question, only: [:new, :create]
  before_action :load_answer, only: [:update, :destroy, :set_best]

  # after_action :publish_answer, only: :create

  respond_to :js
  # respond_to :json, only: [:create, :destroy]
  authorize_resource

  def create
    respond_with(@answer = @question.answers.create(answer_params.merge({ user: current_user })))
  end

  def update
    @answer.update(answer_params)
    respond_with @answer
  end

  def destroy
    respond_with(@answer.destroy)
  end

  def set_best
    respond_with @answer.toggle_best!
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
    @question = @answer.question
  end

  def publish_answer
    PrivatePub.publish_to("/questions/#{@question.id}/answers", answer: @answer.to_json) if @answer.valid?
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file])
  end
end
