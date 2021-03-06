require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :name }
  it { should ensure_length_of(:name).is_at_most(20) }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  it { should have_many(:questions).dependent(:destroy) }
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:votes) }

  describe 'Check voting for user' do
    let!(:user) { create(:user) }

    context 'when votable present' do
      let(:vote) { create(:vote, user: user) }
      let(:question) { create(:question, votes: [vote], user: user) }

      describe '#can_vote_up?(votable)' do
        it 'can vote up' do
          expect( user.can_vote_up?( question ) ).to be true
        end

        it 'do not can vote up' do
          vote.update( score: 1 )
          expect( user.can_vote_up?( question ) ).to be false
        end
      end

      describe '#can_vote_down?(votable)' do
        it 'can vote down' do
          expect( user.can_vote_down?( question ) ).to be true
        end

        it 'do not can vote down' do
          vote.update( score: -1 )
          expect( user.can_vote_down?( question ) ).to be false
        end
      end
    end

    context 'when user has not votes' do
      let(:question) { create(:question, user: user) }
      it '#can_vote_up? return true' do
        expect(user.can_vote_up?( question )).to be true
      end
      it '#can_vote_down? return true' do
        expect(user.can_vote_down?( question )).to be true
      end
    end

  end

  describe '.find_for_oauth' do
    let!(:user) { create(:user) }
    let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456') }
    context 'user already has authorization' do
      it 'returns the user' do
        user.authorizations.create(provider: 'facebook', uid: '123456')
        expect(User.find_for_oauth(auth)).to eq user
      end
    end

    context 'user has not authorization' do
      context 'user already exists' do
        let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { email: user.email }) }
        it 'does not create new user' do
          expect { User.find_for_oauth(auth) }.to_not change(User, :count)
        end

        it 'creates authorization for user' do
          expect { User.find_for_oauth(auth) }.to change(user.authorizations, :count).by(1)
        end

        it 'creates authorization with provider and uid' do
          authorization = User.find_for_oauth(auth).authorizations.first

          expect(authorization.provider).to eq auth.provider
          expect(authorization.uid).to eq auth.uid
        end

        it 'returns the user' do
          expect(User.find_for_oauth(auth)).to eq user
        end
      end

      context 'user does not exist' do
        let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { email: 'new@user.com' }) }
        it 'creates new user' do
          expect { User.find_for_oauth(auth) }.to change(User, :count).by(1)
        end
        it 'returns new user' do
          expect(User.find_for_oauth(auth)).to be_a(User)
        end
        it 'fills user email' do
          user = User.find_for_oauth(auth)
          expect(user.email).to eq auth.info[:email]
        end
        it 'creates authorization for user' do
          user = User.find_for_oauth(auth)
          expect(user.authorizations).to_not be_empty
        end
        it 'creates authorization with provider and uid' do
          authorization = User.find_for_oauth(auth).authorizations.first
          expect(authorization.provider).to eq auth.provider
          expect(authorization.uid).to eq auth.uid
        end
      end
    end
  end
end
