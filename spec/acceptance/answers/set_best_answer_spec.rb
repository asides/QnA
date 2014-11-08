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
  given!(:answer3) { create(:answer, question: question, user: user) }

  background do |example|
    sign_in(user) unless example.metadata[:skip_sign_in]
    visit question_path(question)
  end

  scenario 'Автор вопроса отмечает ответ как верный', js: true do

    within "#answer-#{answer.id}" do
      expect(page).to_not have_selector('.best-answer')

      click_on 'Best/Unbest answer'

      expect(page).to have_selector('.best-answer')
    end
  end

  scenario 'Автор вопроса удаляет метку верного ответа', js: true do
    within "#answer-#{best_answer.id}" do
      click_on 'Best/Unbest answer'
    end

    expect(page).to_not have_selector('.best-answer')
  end

  scenario 'Автор вопроса не может отметить несколько ответов как верные', js: true do
    within "#answer-#{answer.id}" do
      click_on 'Best/Unbest answer'
    end

    within "#answer-#{answer2.id}" do
      click_on 'Best/Unbest answer'
    end

    expect(find("#answer-#{answer.id}")).to_not have_selector('.best-answer')
    expect(find("#answer-#{answer2.id}")).to have_selector('.best-answer')

    expect(page).to have_selector('.best-answer', count: 1)

  end

  scenario 'Пользователь не может отмечать ответы если он не автор вопроса', :skip_sign_in do
    sign_in(answer_user)
    visit question_path(question)

    expect(page).to_not have_selector('.set-best-answer')
  end

  scenario 'Автор вопроса не может отметить ответ на свой вопрос если он автор ответа' do
    within("#answer-#{answer3.id}") do
      expect(page).to_not have_selector('.set-best-answer')
    end
  end

  scenario 'Гость не может отмечать ответы как верные', :skip_sign_in do
    expect(page).to_not have_selector('.set-best-answer')
  end
end
