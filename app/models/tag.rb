class Tag < ActiveRecord::Base

  searchkick autocomplete: ['name'], language: "Russian"

  has_many :questions, through: :taggings
  has_many :taggings

  validates :name, presence: true, uniqueness: {case_sensitive: false}

end
