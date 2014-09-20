class Answer < ActiveRecord::Base

  belongs_to :question

  validates :body, length: { maximum: 1000 }, presence: true
  # validates :question, presence: true
end
