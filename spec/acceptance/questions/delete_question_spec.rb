require_relative "../acceptance_helper"

feature "Автор вопроса может удалить свой вопрос" do
  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { create(:question, user: user) }

  scenario "Автор вопроса удаляет свой вопрос" do
    sign_in user
    
    visit question_path(question)
    click_on 'Удалить вопрос'

    expect(current_path).to eq questions_path
    expect(page).to have_content "Question with id:#{question.id} deleted!"
  end
  
  scenario "Аутентифицированный пользователь не может удалять вопросы другх пользователей" do
    sign_in user2   
    visit question_path(question)  
    expect(page).to_not have_link 'Удалить вопрос'
  end

  scenario "Гость не может удалять вопросы" do
    visit question_path(question)  
    expect(page).to_not have_link 'Удалить вопрос'
  end
end
