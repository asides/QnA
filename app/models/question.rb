class Question < ActiveRecord::Base

	has_many :answer, dependent: :destroy

	validates :title, length: { maximum: 255 }, presence: true
	validates :body, length: { maximum: 1000 }, presence: true

end
