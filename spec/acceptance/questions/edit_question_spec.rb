require "rails_helper"

feature "Edit question" do
  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { create(:question, user: user) }

  scenario "Аутентифицированный пользователь редактирует свой вопрос" do
    sign_in user
    visit question_path(question)
    click_on 'Edit'
    fill_in "Title", with: "Question title"
    fill_in 'Body', with: 'text text'
    click_on 'Сохранить вопрос'
    
    expect(current_path).to eq question_path(question)

    within('#question') do
      expect(page).to have_content 'Question title'
      expect(page).to have_content 'text text'
    end
  end

  scenario "Аутентифицированный пользователь не может редактировать чужой вопрос" do
    sign_in user2
    visit question_path(question)
    expect(page).to_not have_link('Edit', href: edit_question_path(question))
  end
  
  scenario "Гость не может редактировать вопросы" do
    visit question_path(question)

    expect(page).to_not have_link('Edit', href: edit_question_path(question))
  end

  
end
