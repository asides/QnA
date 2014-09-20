require 'rails_helper'

RSpec.describe AnswersController, :type => :controller do

  let(:question) { create(:question) }
  let(:answer) { create(:answer) }
  let(:attributes) { attributes_for(:answer) }

	describe "GET #new" do
    before { get :new, question_id: question}

    it "assigns the requested question to @question" do
      expect(assigns(:question)).to eq question
    end

    it "assigns new answer to @answer" do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it "render new view" do
      expect(response).to render_template :new
    end
	end

  describe "POST #create" do
    let(:post_create) { post :create, question_id: question, answer: attributes }

    context 'with valid attributes' do
      it "save new answer to DB" do
        expect(post_create).to change(Answer, :count).by(1)
      end

      it "redirect to question" do
        post_create.call
        expect(response).to redirect_to question
      end
    end

    context 'with invalid attributes' do
      let(:attributes) { attributes_for(:answer, body: nil) }

      it "does not save answer with invalid attributes" do
        expect(post_create).to_not change(Answer, :count)
      end

      it "re-render new view" do
        post_create.call
        expect(response).to render_template :new
      end
    end
  end

end
