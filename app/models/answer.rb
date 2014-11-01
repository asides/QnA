class Answer < ActiveRecord::Base

  belongs_to :user
  belongs_to :question
  has_many :attachments, as: :attachmentable
  has_many :comments, as: :commentable


  validates :body, length: { maximum: 1000 }, presence: true
  validates :question, presence: true

  accepts_nested_attributes_for :attachments

  default_scope -> { order :created_at }
end
