module QuestionsHelper
  def questions_count
    if Question.count > 0
      Question.count
    else
      "0"
    end
  end
end
