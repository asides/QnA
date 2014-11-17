require 'rails_helper'

RSpec.describe Vote, :type => :model do

  it { should validate_presence_of :score }

  it { should belong_to :user }
  it { should belong_to :votable }

  let(:vote) { create(:vote) }

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
end
