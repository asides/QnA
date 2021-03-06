require_relative '../acceptance_helper'

feature 'Аутентифицированный пользователь может создавать ответы на вопросы' do
  given!(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  scenario 'Аутентифицированный пользователь создает ответ на вопрос', js: true do
    sign_in(user)
    visit question_path(question)
    fill_in 'Ваш ответ', with: 'My answer'
    click_on 'Ответить на вопрос'

    expect(current_path).to eq question_path(question)
    within '#answers' do
      expect(page).to have_content 'My answer'
    end
  end

  scenario 'Аутентифицированный пользователь пытается отправить невалидный ответ', js: true do
    sign_in(user)
    visit question_path(question)
    click_on 'Ответить на вопрос'

    expect(page).to have_content 'Body не может быть пустым'
  end

  scenario 'Гость не может ответить на вопрос' do
    visit question_path(question)

    expect(page).to_not have_css('form#new_answer')
    expect(page).to have_content('Зарегистрируйтесь или войдите для того, что бы отвечать на вопросы.')
  end
end
