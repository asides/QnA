class Tagging < ActiveRecord::Base
  belongs_to :tag, counter_cache: :questions_count
  belongs_to :question
end
