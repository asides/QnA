require_relative '../acceptance_helper'

feature 'Голосование за вопрос', %q{
  Для того чтобы показать полезность вопроса
  Если я не автор вопроса и зарегистрированный пользователь
  Я могу проголосовать за вопрос в большую или меньшую сторону
} do

  given!(:user) { create(:user) }
  given!(:other_author) { create(:user) }
  given!(:question) { create(:question, user: user) }

  background do |example|
    sign_in(other_author) unless example.metadata[:skip_sign_in]
    visit question_path(question)
  end

  scenario 'Гость не может голосовать', :skip_sign_in do
    within "#question-#{question.id} .question-#{question.id}-voting" do
      expect(page).to_not have_content('UP')
      expect(page).to_not have_content('Down')
    end
  end

  scenario 'Автор вопроса не может голосовать за свой вопрос', :skip_sign_in do
    sign_in(user)
    visit question_path(question)
    within "#question-#{question.id} .question-#{question.id}-voting" do
      expect(page).to_not have_content('UP')
      expect(page).to_not have_content('Down')
    end
  end

  scenario 'Пользователь позитивно голосует за вопрос', js: true do
    within "#question-#{question.id} .question-#{question.id}-voting" do
      expect(page).to have_content( '0' )
      click_on 'Up'
      expect(page).to have_content( '1' )
      expect(page).to_not have_content('UP')
    end
  end

  scenario 'Пользователь отрицательно голосует за вопрос', js: true do
    within "#question-#{question.id} .question-#{question.id}-voting" do
      expect(page).to have_content( '0' )
      click_on 'Down'
      expect(page).to have_content( '-1' )
      expect(page).to_not have_content('Down')
    end
  end
end
