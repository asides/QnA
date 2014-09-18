class Question < ActiveRecord::Base
	validates :title, :body, presence: true
	validates :title, length: { maximum: 255 }
	validates :body, length: { maximum: 1000 }

	has_many :answer, dependent: :destroy
end
