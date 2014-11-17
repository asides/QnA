require_relative '../acceptance_helper'

feature 'Голосование за вопрос', %q{
  Для того чтобы показать полезность вопроса
  Если я не автор вопроса и зарегистрированный пользователь
  Я могу проголосовать за вопрос в большую или меньшую сторону
} do

  given!(:user) { create(:user) }
  given!(:other_author) { create(:user) }
  given!(:question) { create(:question, user: user) }

  scenario 'Пользователь позитивно голосует за вопрос', js: true do
    sign_in(user)
    visit question_path question

    within('.total_voted') do
      expect(page).to have_content( '0' )
    end

    click_on 'Up'

    within('.total_voted') do
      expect(page).to have_content( '1' )
    end
    # expect(page).to_not have_content('Vote UP')
  end

end
