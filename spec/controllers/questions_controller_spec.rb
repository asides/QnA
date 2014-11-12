require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  let(:user) { create(:user) }
  let(:user2) { create(:user) }

  let(:question) { create(:question, user: user) }
  let(:question2) { create(:question, user: user2) }

  sign_in_user

  describe 'GET #index', skip_sign_in: true do
    let(:questions) { create_list(:question, 2) }
    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show', skip_sign_in: true do
    before { get :show, id: question }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { get :new }

    context 'when user is sign in' do
      it 'assigns a new Questions to @question' do
        expect(assigns(:question)).to be_a_new(Question)
      end

      it 'renders new view' do
        expect(response).to render_template :new
      end
    end

    context 'when user is not sign in', skip_sign_in: true do
      it 'redirect to sign in' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #edit' do
    context 'when user logged in' do
      before { get :edit, id: question }

      it 'assigns the requested question to @question' do
        expect(assigns(:question)).to eq question
      end

      context 'and user is author of the question' do
        it 'renders edit view' do
          expect(response).to render_template :edit
        end
      end

      context 'and user is not author of the question' do
        it 'redirects to root_path' do
          get :edit, id: question2
          expect(response).to redirect_to root_path
        end
      end

    end

    context 'when user not logged in', skip_sign_in: true do
      it 'redirects to sign in' do
        get :edit, id: question
        expect(response).to redirect_to new_user_session_path
      end
    end

  end

  describe 'POST #create' do
    context 'when user logged in' do
      context 'with valid attributes' do
        it 'saves the new question in DB' do
          expect { post :create, question: attributes_for(:question, user: user) }.to change(Question, :count).by(1)
        end

        it 'create tag_list for question' do
          post :create, question: attributes_for(:question, user: user, tag_list: 'a,b,c')
          expect(assigns(:question).tag_list).to eq 'A,B,C'
        end

        it 'redirects to show view' do
          post :create, question: attributes_for(:question, user: user)
          expect(response).to redirect_to question_path(assigns(:question))
        end
      end

      context 'with invalid attributes' do
        it 'does not saves question in DB' do
          expect { post :create, question: attributes_for(:invalid_question) }.to_not change(Question, :count)
        end

        it 're-renders new view' do
          post :create, question: attributes_for(:invalid_question)
          expect(response).to render_template :new
        end
      end
    end

    context 'when user not logged in', skip_sign_in: true do
      it 'redirects to sign in' do
        post :create, question: attributes_for(:question)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH #update' do
    context 'when user logged in' do
      context 'and user is author of the question' do
        context 'whith valid attributes' do
          it 'assigns the requested question to @question' do
            patch :update, id: question, question: attributes_for(:question)
            expect(assigns(:question)).to eq question
          end

          it 'changes question attributes' do
            patch :update, id: question, question: { title: 'new title', body: 'new body' }
            question.reload
            expect(question.title).to eq 'new title'
            expect(question.body).to eq 'new body'
          end

          it 'redirects to the updated question' do
            patch :update, id: question, question: attributes_for(:question)
            expect(response).to redirect_to question
          end
        end

        context 'whith invalid attributes' do
          before { patch :update, id: question, question: { title: 'new title', body: nil } }

          it 'does not change question attributes' do
            question.reload
            expect(question.title).to eq 'MyString'
            expect(question.body).to eq 'MyText'
          end

          it 're-renders edit view' do
            expect(response).to render_template :edit
          end
        end
      end

      context 'and user is not author of the question' do
        it 'redirects to root_path' do
          patch :update, id: question2, question: attributes_for(:question)
          expect(response).to redirect_to root_path
        end
      end
    end

    context 'when user not logged in', skip_sign_in: true do
      it 'redirects to sign in' do
        patch :update, id: question, question: attributes_for(:question)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'DELETE #destroy' do
    before { question }
    before { question2 }

    context 'when user logged in' do
      it 'with author deletes question' do
        expect { delete :destroy, id: question, user: user }.to change(Question, :count).by(-1)
      end

      it 'with other user deletes question' do
        expect { delete :destroy, id: question2, user: user }.to_not change(Question, :count)
      end

      it 'redirect to index questions view' do
        delete :destroy, id: question, user: user
        expect(response).to redirect_to questions_path
      end
    end

    context 'when user not logged in', skip_sign_in: true do
      it 'redirects to sign in' do
        delete :destroy, id: question
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

end
