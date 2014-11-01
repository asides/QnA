class Question < ActiveRecord::Base

  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachmentable, dependent: :destroy
  has_many :comments, as: :commentable

  validates :title, length: { maximum: 300 }, presence: true
  validates :body, length: { maximum: 10000 }, presence: true

  accepts_nested_attributes_for :attachments

  default_scope -> { order created_at: :desc }
end
