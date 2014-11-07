require_relative '../acceptance_helper'

feature 'Автор вопроса может отметить один ответ как верный', %q{
  Для того чтобы показать правильный ответ
  Я как автор вопроса
  Могу пометить один из ответов на мой вопрос как верный
} do

  given!(:user) { create(:user) }
  given!(:answer_user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: answer_user) }
  given!(:answer2) { create(:answer, question: question, user: answer_user) }
  given!(:best_answer) { create(:answer, best: true, question: question, user: answer_user) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'Автор отмечает ответ как верный', js: true do
    within "#answer-#{answer.id}" do
      expect(page).to_not have_selector('.best-answer')

      click_on 'It\'s best answer!'

      expect(page).to have_selector('.best-answer')
    end
  end

  scenario 'Автор удаляет метку верного ответа', js: true do
    within "#answer-#{best_answer.id}" do
      click_on 'Unbest answer'
    end

    expect(page).to_not have_selector('.best-answer')
  end

  scenario 'Автор вопроса не может отметить несколько ответов как верные', js: true do
    within "#answer-#{answer.id}" do
      click_on 'It\'s best answer!'
    end

    within "#answer-#{answer2.id}" do
      click_on 'It\'s best answer!'
    end

    expect(page).to have_selector('.best-answer', count: 1)
    expect(find("#answer-#{answer2.id}")).to have_selector('.best-answer')

  end

  # scenario 'Аутентифицированный пользователь не может отмечать ответы других пользователей' do
  # end
  # scenario 'Гость не может отмечать ответы как верные'
end
