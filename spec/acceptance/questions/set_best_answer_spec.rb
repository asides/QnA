require_relative '../acceptance_helper'

feature 'Автор вопроса может отметить один ответ как верный', %q{
  Для того чтобы показать правильный ответ
  Я как автор вопроса
  Могу пометить один из ответов на мой вопрос как верный
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'Автор отмечает ответ как верный', js: true do
    within find("#answer-#{answer.id}") do
      expect(has_selector?('.best-answer')).to be false

      find('a.set-best-answer').click

      expect(has_selector?('.best-answer')).to be true
    end
  end

  scenario 'Автор удаляет метку верного ответа'
  scenario 'Автор вопроса не может отметить несколько ответов как верные'
  scenario 'Аутентифицированный пользователь не может отмечать ответы других пользователей'
  scenario 'Гость не может отмечать ответы как верные'
end
