class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook]

  has_many :authorizations
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :votes

  validates :name, length: { maximum: 20 }, presence: true

  def self.find_for_oauth(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return authorization.user if authorization

    email = auth.info[:email]
    user = User.where(email: email).first

    if user
      user.create_authorization(auth)
    else
      password = Devise.friendly_token[0,20]
      user = User.create!(name: 'User', email: email, password: password, password_confirmation: password )
      user.create_authorization(auth)
    end
    user
  end

  def create_authorization(auth)
    self.authorizations.create(provider: auth.provider, uid: auth.uid)
  end

  def can_vote_up?(votable)
    if self.votes.where(votable: votable).present?
      self.votes.where(votable: votable).first.score < 1
    else
      return true
    end
  end

  def can_vote_down?(votable)
    if self.votes.where(votable: votable).present?
      self.votes.where(votable: votable).first.score > -1
    else
      return true
    end
  end
end
