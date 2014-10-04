require "rails_helper"

feature "Аутентифицированный пользователь может создавать ответы на вопросы" do
  given(:user) { create(:user) }
  given(:question) { create(:question) }
  
  scenario "Аутентифицированный пользователь создает ответ на вопрос", js: true do
    sign_in(user)
    visit question_path(question)
    fill_in "Ваш ответ", with: "My answer"
    click_on 'Ответить на вопрос'

    expect(current_path).to eq question_path(question)
    within ".answers" do
      expect(page).to have_content "My answer"
    end
  end

  scenario "Гость не может ответить на вопрос"
end
