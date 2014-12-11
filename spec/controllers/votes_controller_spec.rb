require 'rails_helper'

RSpec.describe VotesController, :type => :controller do
  let!(:user) { create(:user) }
  let!(:other) { create(:user) }
  let!(:question) { create(:question, user: other) }
  let!(:vote) { create(:vote, votable: question, user: user) }

  sign_in_user

  describe 'PATCH #up' do
    before { allow( request ).to receive(:path) { up_question_path(question) } }

    it 'increases by 1 vote' do
      patch :up, id: vote, format: :js

      expect(vote.reload.score).to eq 1
    end

    it 'score can not increase more than 1' do
      vote.update(score: 1)
      patch :up, id: vote, format: :js
      expect(vote.reload.score).to eq 1
    end
  end

  describe 'PATCH #down' do
    before { allow( request ).to receive(:path) { down_question_path(question) } }
    it 'decreases by 1 vote' do
      patch :down, id: vote, format: :js

      expect(vote.reload.score).to eq -1
    end

    it 'score can not decrease more than -1' do
      vote.score = -1
      patch :down, id: vote, format: :js
      expect(vote.reload.score).to eq -1
    end
  end

end
