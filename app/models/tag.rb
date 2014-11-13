class Tag < ActiveRecord::Base
  searchkick autocomplete: ['name'], language: "Russian"

  has_many :taggings
  has_many :questions, through: :taggings

  validates :name, presence: true, uniqueness: {case_sensitive: false}
end
