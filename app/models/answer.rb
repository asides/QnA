class Answer < ActiveRecord::Base

  belongs_to :user
  belongs_to :question
  has_many :attachments, as: :attachmentable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy

  validates :body, length: { maximum: 1000 }, presence: true
  validates :question, presence: true

  accepts_nested_attributes_for :attachments

  default_scope -> { order :created_at }


  def toggle_best!
    best ? unset_best : set_best
  end

  private

  def set_best
    best_answer = question.best_answer
    best_answer.update(best: false) if best_answer
    update best: true
  end

  def unset_best
    update best: false
  end
end
