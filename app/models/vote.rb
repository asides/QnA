class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates :score, presence: true

  def vote_up!
    update(score: self.score+=1) if self.score < 1
  end

  def vote_down!
    update(score: self.score-=1) if self.score > -1
  end
end
