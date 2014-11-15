class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true

  def up
    self.score += 1
  end

  def down
    self.score -= 1
  end
end
