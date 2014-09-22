require "rails_helper"

feature "Create question", %q{
Для того чтобы получить ответ от сообщества
Как аутентифицированный пользователь
Я хочу задавать вопросы
  } do
  scenario "Аутентифицированный пользователь создает вопрос" do
    User.create!(email: 'user@test.com', password: '12345678')

    visit new_user_session_path
    fill_in 'Email', with: 'user@test.com'
    fill_in 'Password', with: '12345678'
    click_on 'Sign in'

    visit questions_path
    click_on 'Создать новый вопрос'
    fill_in "Title", with: "Test question"
    fill_in "Body", with: "text text"
    click_on 'Create'

    expect(page).to have_content 'Ваш вопрос успешно добавлен!'
  end

  scenario 'Не аутентифицированный пользователь пытается создать вопрос' do
    visit questions_path
    click_on 'Создать новый вопрос'

    expect(page).to have_content 'Вам необходимо войти в систему или зарегистрироваться.'
  end
end
