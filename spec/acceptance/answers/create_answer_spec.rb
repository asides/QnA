require "rails_helper"

feature "User answer", %q{
Я могу создавать ответ на вопрос
Как зарегистрированный пользователь
Для того, что бы поделиться знаниями
} do
  given(:user) { create(:user) }
  given(:question) { create(:question) }
  scenario "Зарегистрированный пользователь создает ответ" do
    sign_in(user)
    visit question_path(question)
    click_on 'Ответить на вопрос'
  end
end
