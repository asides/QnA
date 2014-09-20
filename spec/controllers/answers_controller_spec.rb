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
        expect{ post_create }.to change(Answer, :count).by(1)
      end

      it "redirect to question" do
        post_create
        expect(response).to redirect_to question
      end
    end

    context 'with invalid attributes' do
      let(:attributes) { attributes_for(:answer, body: nil) }

      it "does not save answer with invalid attributes" do
        expect{ post_create }.to_not change(Answer, :count)
      end

      it "re-render new view" do
        post_create
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

  describe "PATCH #update" do
    before {patch :update, id: answer, answer: attributes}

    context 'with valid attributes' do
      let(:attributes) { { body: '123' } }

      it "update answer record" do
        answer.reload
        expect(answer.body).to eq '123'
      end

      it "redirects to the associated question" do
        patch :update, id: answer, answer: { body: '123' }
        expect(response).to redirect_to answer.question
      end
    end

    context 'with invalid attributes' do
      let(:attributes) { { body: nil } }

      it "does not save record" do
        expect(answer.body).to eq 'MyText'
      end

      it "re-renders edit view" do
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    before { answer }

    it "deletes answer" do
      expect { delete :destroy, id: answer }.to change(Answer, :count).by(-1)
    end

    it "redirects to associated question" do
      delete :destroy, id: answer
      expect(response).to redirect_to answer.question
    end

  end
end
