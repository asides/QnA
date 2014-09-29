require "rails_helper"

feature "Edit question" do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario "Аутентифицированный пользователь редактирует свой вопрос" do
    sign_in(user)
    visit question_path(question)
    click_on 'Edit'
    fill_in 'Body', with: 'text text'
    click_on 'Create'

    within('.question') do
      expect(page).to have_content 'text text'
    end
  end

  scenario "Аутентифицированный пользователь не может редактировать чужой вопрос"
  
  scenario "Гость не может редактировать вопросы" do
    visit question_path(question)

    expect(page).to_not have_button('Edit')
  end

  
end
