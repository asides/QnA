require 'rails_helper'

feature 'Вход пользователя', %q{
  Для того что бы завать вопросы
  Как пользователь
  Я хочу войти
} do

  given(:user) { create(:user) }
  scenario 'Зарегистрированный пользователь пытается войти' do
    sign_in(user)

    expect(page).to have_content 'Вход в систему выполнен.'
    expect(current_path).to eq root_path
  end

  scenario 'Не зарегистрованный пользователь пытается войти' do
    visit new_user_session_path
    fill_in 'Email', with: 'wrong@test.com'
    fill_in 'Password', with: '12345678'
    click_on 'Sign in'

    expect(page).to have_content 'Неверный адрес эл. почты или пароль.'
    expect(current_path).to eq new_user_session_path
  end
end
