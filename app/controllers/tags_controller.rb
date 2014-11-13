class TagsController < ApplicationController

  skip_authorization_check

  def index
    respond_with @tags = Tag.all
  end

  def autocomplete
    render json: Tag.search(params[:query], autocomplete: true, limit: 10).map(&:name)
  end
end
