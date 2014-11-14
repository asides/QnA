require 'rails_helper'

RSpec.describe Question, type: :model do

  it { should validate_presence_of :title }
  it { should ensure_length_of(:title).is_at_most(300) }

  it { should validate_presence_of :body }
  it { should ensure_length_of(:body).is_at_most(10000) }

  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:attachments).dependent(:destroy) }

  it { should belong_to :user }

  it { should accept_nested_attributes_for :attachments }

  it { should have_many :taggings }
  it { should have_many :tags }

  describe '#best_answer' do
    let(:question) { create(:question) }
    let!(:answers) { create_list(:answer, 2, question: question) }
    let!(:best_answer) { create(:answer, question: question, best: true) }

    it 'best_answer return best answer' do
      expect(question.best_answer).to eq best_answer
    end
  end

  describe '#tag_list' do

    let(:tags) { create_list(:tag, 3 ) }
    let(:question) { create(:question, tags: tags) }

    it 'shoud have string with 3 tags' do
      expect( question.tag_list ).to match(/tag\d+,tag\d+,tag\d+/)
    end
  end

  describe '#tag_list=' do
    let!(:question) { create(:question) }

    it 'should have new tags string with strip and lowercase' do
      question.tag_list='a,B ,  c, d   ,e '
      question.reload

      expect(question.tag_list).to eq 'a,b,c,d,e'
    end
  end
end
