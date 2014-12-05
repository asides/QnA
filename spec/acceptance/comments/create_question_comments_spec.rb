require_relative '../acceptance_helper'

feature 'Добавление комментариев к вопросу', %q{
  Для того что бы высказать дополнительные мысли
  Я как авторизированнный пользователь
  Могу добавить комментарний к вопросу
} do

  given!(:user) { create(:user, admin: true) }
  given(:question) { create(:question, user: user) }

  background do |example|
    sign_in(user) unless example.metadata[:skip_sign_in]
    visit question_path(question)
  end

  describe 'Пользователь пытается добавить комментарий' do
    background do
      within '.new_question_comment' do
        click_on 'Add new comment'
      end
    end

    context 'Пользователь не залогинился' do
      scenario 'Пользователь видит предложение войти или зарегистрироваться', :skip_sign_in  do
        within '.new_question_comment' do
          expect(page).to have_link('войти', href: new_user_session_path)
          expect(page).to have_link('зарегистрироваться', href: new_user_registration_path)
        end
      end
    end

    context 'Пользователь залогинился' do
      scenario 'Пользователь добавляет валидный комментарий', js: true do
        within '.new_question_comment' do
          fill_in 'New comment', with: 'New comment for question'
          click_on 'Send comment'
        end
        expect(current_path).to eq question_path(question)
        within '#question .comments' do
          expect(page).to have_content 'New comment for question'
        end
        within '#question' do
          expect(page).to_not have_selector('form#new_comment')
        end
      end

      scenario 'Пользователь добавляет не валидный комментарий', js: true do
        within '.new_comment_form' do
          fill_in 'New comment', with: ''
          click_on 'Send comment'
        end

        within '#question' do
          expect(page).to have_selector('form#new_comment')
          expect(page).to have_content('не может быть пустым')
        end
      end
    end
  end
end
