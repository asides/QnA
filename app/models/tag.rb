class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :questions, through: :taggings

  validates :name, presence: true, uniqueness: {case_sensitive: false}
end
