require_relative '../acceptance_helper'

feature 'Голосование за ответ', %q{
  Для того чтобы показать полезность ответа
  Если я не автор ответа и зарегистрированный пользователь
  Я могу проголосовать за ответ в большую или меньшую сторону
} do

  given!(:user) { create(:user) }
  given!(:other_author) { create(:user) }
  given(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, user: user)}

  background do |example|
    sign_in(other_author) unless example.metadata[:skip_sign_in]
    visit question_path(question)
  end

  scenario 'Пользователь позитивно голосует за ответ', js: true do
    within "#answer-#{answer.id} .total_voted" do
      expect(page).to have_content( '0' )
      click_on 'Up'
      expect(page).to have_content( '1' )
      expect(page).to_not have_content('UP')
    end
  end

end
