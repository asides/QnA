require_relative '../acceptance_helper'

feature 'Автор ответа может удалять свои ответы' do
  given!(:user) { create(:user) }
  given(:other) { create(:user) }

  given(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, user: user) }



  scenario 'Автор ответа удаляет свой ответ', js: true do
    sign_in user
    visit question_path(question)

    within("#answer-#{answer.id}") do
      click_on 'Удалить'
    end
      expect(page).to_not have_content(answer.body)
  end

  scenario 'Аутентифицированный пользователь не может удалить чужой ответ' do
    sign_in other
    visit question_path(question)
    within('#answers') do
      expect(page).to_not have_link('Удалить', href: "#{answer_path(answer)}")
    end
  end

  scenario 'Гость не может удалять ответы' do
    visit question_path(question)
    within('#answers') do
      expect(page).to_not have_link('Удалить', href: "#{answer_path(answer)}")
    end
  end
end
