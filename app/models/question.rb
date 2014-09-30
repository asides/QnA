class Question < ActiveRecord::Base

  belongs_to :user
  has_many :answers, dependent: :destroy

  validates :title, length: { maximum: 255 }, presence: true
  validates :body, length: { maximum: 1000 }, presence: true

end
