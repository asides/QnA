require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should validate_presence_of :body }
  it { should ensure_length_of(:body).is_at_most(1000) }

  it { should belong_to(:question) }
  it { should have_many :attachments }
  it { should validate_presence_of :question }

  it { should belong_to(:user) }

  it { should accept_nested_attributes_for :attachments }

  describe 'instance methods' do
    let(:question) { create(:question) }

    let!(:answer) { create(:answer, question: question) }
    let!(:answer2) { create(:answer, question: question) }

    describe 'set\unset best trigger for answer' do

      it 'set answer as best' do
        answer.trigger_best!
        expect(answer).to be_best

        answer.trigger_best!
        expect(answer).to_not be_best
      end

      it 'only one answer will be set as best' do
        answer.trigger_best!
        answer2.trigger_best!
        expect(question.answers.best_answer.count).to eq 1
      end
    end
  end
end
