require "rails_helper"

feature "Аутентифицированный пользователь может создавать ответы на вопросы" do
  given(:user) { create(:user) }
  given(:question) { create(:question) }
  
  scenario "Аутентифицированный пользователь создает ответ на вопрос" do
    sign_in(user)
    visit question_path(question)
    click_on 'Ответить на вопрос'
  end

  scenario "Гость не может ответить на вопрос"
end
