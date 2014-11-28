class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates :score, presence: true

  after_save :update_parent_total_voted

  def vote_up!
    update(score: self.score+=1) if self.score < 1
  end

  def vote_down!
    update(score: self.score-=1) if self.score > -1
  end

  private

  def update_parent_total_voted
    v = self.votable
    total = v.votes.sum :score
    v.update(total_voted: total)
  end
end
