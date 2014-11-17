class VotesController < ApplicationController

  before_action :authenticate_user!
  before_action :find_parent
  before_action :load_vote

  respond_to :js

  authorize_resource

  def up
    @vote.vote_up!
    respond_with @vote
  end

  def down
    @vote.vote_down!
    respond_with @vote
  end

  private

  def load_vote
    @vote = Vote.find_or_create_by( votable: @parent, user: current_user )
  end

end
