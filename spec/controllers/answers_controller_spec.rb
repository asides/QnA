require 'rails_helper'

RSpec.describe AnswersController, :type => :controller do

  let!(:question) { create(:question) }

  describe "POST #create" do
    
    context 'with valid attributes' do
      it "save new answer to DB" do 
        expect { post :create, answer: attributes_for(:answer), question_id: question, format: :js }.to change(question.answers, :count).by(1)
      end

      it "render create template" do
        post :create, answer: attributes_for(:answer), question_id: question, format: :js
        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      let(:attributes) { attributes_for(:answer, body: nil) }

      it "does not save answer with invalid attributes" do
        expect { post :create, answer: attributes_for(:invalid_answer), question_id: question, format: :js }.to_not change(Answer, :count)
      end

      it "redirect to question show view" do
        post :create, answer: attributes_for(:invalid_answer), question_id: question, format: :js
        expect(response).to render_template :create
      end
    end
  end

  describe "PATCH #update" do
    let(:answer) { create(:answer, question: question) }

    it "assign the requested answer to @answer" do
      patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
      expect(assigns(:answer)).to eq answer
    end

    it "assign the @question" do
      patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
      expect(assigns(:question)).to eq question
    end

    it "changes answer attributes" do
      patch :update, id: answer, question_id: question, answer: { body: 'new body' }, format: :js
      answer.reload
      expect(answer.body).to eq 'new body'
    end

    it "render update template " do
      patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
      expect(response).to render_template :update
    end
  end

  # describe "GET #new" do
  #   before { get :new, question_id: question}

  #   it "assigns the requested question to @question" do
  #     expect(assigns(:question)).to eq question
  #   end

  #   it "assigns new answer to @answer" do
  #     expect(assigns(:answer)).to be_a_new(Answer)
  #   end

  #   it "render new view" do
  #     expect(response).to render_template :new
  #   end
  # end

  # describe "GET #edit" do
  #   before {get :edit, id: answer}

  #   it "assigns the requested answer to @answer" do
  #     expect(assigns(:answer)).to eq answer
  #   end

  #   it "render edit view" do
  #     expect(response).to render_template :edit
  #   end
  # end
  # describe "DELETE #destroy" do
  #   before { answer }

  #   it "deletes answer" do
  #     expect { delete :destroy, id: answer }.to change(Answer, :count).by(-1)
  #   end

  #   it "redirects to associated question" do
  #     delete :destroy, id: answer
  #     expect(response).to redirect_to answer.question
  #   end
  # end
end
