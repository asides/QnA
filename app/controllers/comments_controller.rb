class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_parent, only: :create
  before_action :load_comment, only: [:update, :destroy]

  respond_to :js

  authorize_resource

  def create
    respond_with(@comment = @parent.comments.create(comment_params))
  end

  def update
    @comment.update(comment_params)
    respond_with @comment
  end

  private

  def load_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
