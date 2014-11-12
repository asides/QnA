class TagsController < ApplicationController


  skip_authorization_check

  def index
    render json: Tag.select(:name).map(&:name)
    # respond_with @tags
  end

  def show
    respond_with @tag = Tag.where('name like ?', "%#{params[:q]}%")
  end

end
