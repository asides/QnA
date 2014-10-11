class Question < ActiveRecord::Base

  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachmentable, dependent: :destroy

  validates :title, length: { maximum: 255 }, presence: true
  validates :body, length: { maximum: 1000 }, presence: true
  validates :user, presence: true

  accepts_nested_attributes_for :attachments
end
