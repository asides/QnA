require_relative '../acceptance_helper'

feature 'Голосование за комментарий', %q{
  Для того чтобы показать полезность комментария
  Если я не автор ответа и зарегистрированный пользователь
  Я могу проголосовать за комментарий в большую или меньшую сторону
} do

  given!(:user) { create(:user) }
  given!(:other_author) { create(:user) }
  given(:question) { create(:question) }
  given!(:comment) { create(:comment, commentable: question, user: user)}

  background do |example|
    sign_in(other_author) unless example.metadata[:skip_sign_in]
    visit question_path(question)
  end

  scenario 'Гость не может голосовать', :skip_sign_in do
    within "#comment-#{comment.id} .comment-#{comment.id}-voting" do
      expect(page).to_not have_content('UP')
      expect(page).to_not have_content('Down')
    end
  end

  scenario 'Автор комментария не может голосовать за свой комментарий', :skip_sign_in do
    sign_in(user)
    visit question_path(question)
    within "#comment-#{comment.id} .comment-#{comment.id}-voting" do
      expect(page).to_not have_content('UP')
      expect(page).to_not have_content('Down')
    end
  end

  scenario 'Пользователь позитивно голосует за комментарий', js: true do
    within "#comment-#{comment.id} .comment-#{comment.id}-voting" do
      expect(page).to have_content( '0' )
      click_on 'Up'
      expect(page).to have_content( '1' )
      expect(page).to_not have_content('UP')
    end
  end
  scenario 'Пользователь отрицательно голосует за комментарий', js: true do
    within "#comment-#{comment.id} .comment-#{comment.id}-voting" do
      expect(page).to have_content( '0' )
      click_on 'Down'
      expect(page).to have_content( '-1' )
      expect(page).to_not have_content('Down')
    end
  end
end
