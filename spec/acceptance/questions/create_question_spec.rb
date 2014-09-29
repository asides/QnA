require "rails_helper"

feature "Create question", %q{
Для того чтобы получить ответ от сообщества
Как аутентифицированный пользователь
Я хочу задавать вопросы
} do

  given(:user) { create(:user) }
  scenario "Аутентифицированный пользователь создает вопрос" do
    #User.create!(email: 'user@test.com', password: '12345678')

    sign_in(user)

    visit questions_path
    click_on 'Create'
    fill_in "Title", with: "Test question"
    fill_in "Body", with: "text text"
    click_on 'Create'

    expect(page).to have_content 'Ваш вопрос успешно добавлен!'
  end

  scenario "Аутентифицированный пользователь создает вопрос с не валидными данными"

  scenario "Гость не может создать вопрос" do
    visit questions_path
    click_on 'Create'

    expect(page).to have_content 'Вам необходимо войти в систему или зарегистрироваться.'
  end
end
