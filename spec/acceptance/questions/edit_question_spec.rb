require_relative '../acceptance_helper'

feature 'Edit question' do
  given(:author_user) { create(:user) }
  given(:other_user) { create(:user) }
  given(:question) { create(:question, user: author_user) }

  scenario 'Аутентифицированный пользователь редактирует свой вопрос' do
    sign_in(author_user)

    visit question_path(question)
    click_on 'Изменить вопрос'
    fill_in 'Title', with: 'Edit question title'
    fill_in 'Body', with: 'text text'
    click_on 'Сохранить вопрос'

    expect(current_path).to eq question_path(question)

    within('.question') do
      expect(page).to have_content 'Edit question title'
      expect(page).to have_content 'text text'
    end
  end

  scenario 'Аутентифицированный пользователь не может редактировать чужой вопрос' do
    sign_in(other_user)
    visit question_path(question)
    expect(page).to_not have_link('Edit', href: edit_question_path(question))
  end

  scenario 'Гость не может редактировать вопросы' do
    visit question_path(question)

    expect(page).to_not have_link('Edit', href: edit_question_path(question))
  end


end
