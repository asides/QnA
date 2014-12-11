require 'rails_helper'

RSpec.describe Ability, type: :model do
  subject(:ability) { Ability.new(user) }

  describe 'for guest' do
    let(:user) { nil }

    it { should be_able_to :read, Question }
    it { should be_able_to :read, Answer }
    it { should be_able_to :read, Comment }

    it { should_not be_able_to :manage, :all }
  end

  describe 'for admin' do
    let(:user) { create(:user, admin: true) }

    it { should be_able_to :manage, :all }
  end

  describe 'for user' do
    # users
    let!(:user) { create(:user) }
    let!(:other) { create(:user) }
    # questions
    let!(:question) { create(:question, user: user) }
    # answers
    let(:answer) { create(:answer, question: question, user: other) }
    let(:answer2) { create(:answer, question: question, user: user) }


    it { should_not be_able_to :manage, :all }
    it { should be_able_to :read, :all }

    it { should be_able_to :create, Question }
    it { should be_able_to :create, Answer }
    it { should be_able_to :create, Comment }

    # Question
    it { should be_able_to :update, create(:question, user: user), user: user }
    it { should_not be_able_to :update, create(:question, user: other), user: user }

    it { should be_able_to :destroy, create(:question, user: user), user: user }
    it { should_not be_able_to :destroy, create(:question, user: other), user: user }

    #Answer
    it { should be_able_to :update, create(:answer, user: user), user: user }
    it { should_not be_able_to :update, create(:answer, user: other), user: user }

    it { should be_able_to :destroy, create(:answer, user: user), user: user }
    it { should_not be_able_to :destroy, create(:answer, user: other), user: user }

    #Best Answer
    it { should be_able_to :set_best, answer }
    it { should_not be_able_to :set_best, answer2 }

    #Votes
    it { should be_able_to :up, create(:vote, user: user, votable: create(:question, user: other)), user: user}
    it { should_not be_able_to :up, create(:vote, user: user, votable: create(:question, user: user)), user: user}

    it { should be_able_to :down, create(:vote, user: user, votable: create(:question, user: other)), user: user}
    it { should_not be_able_to :down, create(:vote, user: user, votable: create(:question, user: user)), user: user}

    #Comment
    it { should be_able_to :update, create(:comment, user: user), user: user }
    it { should_not be_able_to :update, create(:comment, user: other), user: user }

    it { should be_able_to :destroy, create(:comment, user: user), user: user }
    it { should_not be_able_to :destroy, create(:comment, user: other), user: user }
  end
end
