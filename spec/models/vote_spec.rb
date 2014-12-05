require 'rails_helper'

RSpec.describe Vote, :type => :model do

  it { should validate_presence_of :score }

  it { should belong_to :user }
  it { should belong_to :votable }

  let(:user) { create(:user) }
  let!(:question) { create(:question) }
  let!(:vote) { create(:vote, votable: question, user: user) }

  it 'new vote score always 0' do
    expect(vote.score).to eq 0
  end

  describe '#vote_up!' do
    it 'up score to one point' do
      vote.score = 0
      vote.vote_up!

      expect(vote.score).to eq 1
    end

    it 'never not over 1' do
      vote.score = 1
      vote.vote_up!

      expect(vote.score).to eq 1
    end
  end

  describe '#vote_down!' do
    it 'down score to one point' do
      vote.score = 0
      vote.vote_down!

      expect(vote.score).to eq -1
    end

    it 'never not under -1' do
      vote.score = -1
      vote.vote_down!

      expect(vote.score).to eq -1
    end
  end

  describe 'after_save' do
    it "sends increment_parent_counter" do
      expect(vote).to receive(:update_parent_total_voted)
      vote.save
    end

    it 'update votable total_voted' do
      expect{question.votes.create(score: 1, user_id: user.id)}.to change{question.reload.total_voted}
    end
  end
end
