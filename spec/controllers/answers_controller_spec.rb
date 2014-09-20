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
    # let(:post_create) do
    #   { post :create, question_id: question, answer: attributes }
    # end

    context 'with valid attributes' do
      it "save new answer to DB" do
        expect{ post :create, question_id: question, answer: attributes }.to change(Answer, :count).by(1)
      end

      it "redirect to question" do
        post :create, question_id: question, answer: attributes
        expect(response).to redirect_to question
      end
    end

    context 'with invalid attributes' do
      let(:attributes) { attributes_for(:answer, body: nil) }

      it "does not save answer with invalid attributes" do
        expect{ post :create, question_id: question, answer: attributes }.to_not change(Answer, :count)
      end

      it "re-render new view" do
        post :create, question_id: question, answer: attributes
        expect(response).to render_template :new
      end
    end
  end

  describe "GET #edit" do
    before {get :edit, id: answer}

    it "assigns the requested answer to @answer" do
      expect(assigns(:answer)).to eq answer
    end

    it "render edit view" do
      expect(response).to render_template :edit
    end
  end

end
