class Answer < ActiveRecord::Base

  belongs_to :question
  has_many :attachments, as: :attachmentable

  validates :body, length: { maximum: 1000 }, presence: true
  validates :question, presence: true

  accepts_nested_attributes_for :attachments
end
