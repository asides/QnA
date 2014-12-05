require_relative '../acceptance_helper'

feature 'Автор комментария может редактировать свои комментарии' do
  given(:user) { create(:user) }
  given(:other) { create(:user) }

  given!(:question) { create(:question, user: user) }
  given!(:comment) { create(:comment, commentable: question, user: user) }
  given!(:comment2) { create(:comment, commentable: question, user: other) }

  scenario 'Гость не может редактировать ответы' do
    visit question_path(question)

    within "#comment-#{comment.id}" do
      expect(page).to_not have_link 'Редактировать'
    end
  end

  describe 'Аутентифицированный пользователь' do
    before do
      sign_in user
      visit question_path(question)
    end

    scenario 'видит ссылку на редактирование комментария' do
      within "#comment-#{comment.id}" do
        expect(page).to have_link 'Редактировать'
      end
    end

    scenario 'редактирует свой комментарий', js: true do
      within "#comment-#{comment.id}" do
        click_on 'Редактировать'
        fill_in 'Edit you comment', with: 'edited comment'
        click_on 'Save comment'
        expect(page).to_not have_content comment.body
        expect(page).to have_content 'edited comment'
      end
    end

    scenario 'не может редактировать чужой комментарий' do
      within "#comment-#{comment2.id}" do
        expect(page).to_not have_link 'Редактировать'
      end
    end
  end

end
