class Question < ActiveRecord::Base

  belongs_to :user

  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachmentable, dependent: :destroy
  has_many :comments, as: :commentable
  has_many :votes, as: :votable

  has_many :taggings
  has_many :tags, through: :taggings

  validates :title, length: { maximum: 300 }, presence: true
  validates :body, length: { maximum: 10000 }, presence: true

  accepts_nested_attributes_for :attachments

  default_scope -> { order created_at: :desc }

  scope :tagged, ->(tag) { unscoped.joins(:tags).where("tags.name = ?", tag) }

  def best_answer
    answers.where(best: true).first
  end

  def tag_list
    tags.map { |tag| tag.name }.join(",")
  end

  def tag_list=(list)
    list ||= ''
    names = list.split(',').map { |n| n.mb_chars.strip.downcase }.uniq
    self.tags = names.map { |name| new_tag = Tag.find_or_create_by(name: name) }
  end

  def total_voted
    total = self.votes.sum :score
    total ||= 0
  end
end
