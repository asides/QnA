require_relative '../acceptance_helper'

feature 'Автор комментария может удалить свой комментарий' do
  given!(:user) { create(:user) }
  given(:other) { create(:user) }

  given(:question) { create(:question) }
  given!(:comment) { create(:comment, commentable: question, user: user) }

  scenario 'Гость не может удалять ответы' do
    visit question_path(question)
    within "#comment-#{comment.id}" do
      expect(page).to_not have_link 'Удалить'
    end
  end

  scenario 'Автор комментария удаляет свой комментарий', js: true do
    sign_in user
    visit question_path(question)

    within("#comment-#{comment.id}") do
      click_on 'Удалить'
    end
    expect(page).to_not have_content(comment.body)
  end

  scenario 'Аутентифицированный пользователь не может удалить чужой ответ' do
    sign_in other
    visit question_path(question)
    within "#comment-#{comment.id}" do
      expect(page).to_not have_link 'Удалить'
    end
  end

end
