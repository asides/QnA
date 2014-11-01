require_relative '../acceptance_helper'

feature 'Создание вопроса' do

  given(:user) { create(:user) }
  scenario 'Аутентифицированный пользователь создает вопрос' do
    sign_in user

    visit questions_path
    click_on 'Ask Question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text'
    click_on 'Сохранить вопрос'

    expect(page).to have_content 'Ваш вопрос успешно добавлен!'
  end

  scenario 'Аутентифицированный пользователь создает вопрос с не валидными данными' do
    sign_in user
    visit new_question_path

    fill_in 'Title', with: ''
    fill_in 'Body', with: ''
    click_on 'Сохранить вопрос'

    expect(current_path).to eq questions_path
    expect(page).to have_content 'не может быть пустым'
  end

  scenario 'Гость не может создать вопрос' do
    visit questions_path
    expect(page).to_not have_link 'Создать новый вопрос', href: new_question_path
  end
end
