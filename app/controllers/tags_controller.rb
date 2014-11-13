class TagsController < ApplicationController

  skip_authorization_check

  def autocomplete
    render json: Tag.search(params[:query], autocomplete: true, limit: 10).map(&:name)
  end
end
