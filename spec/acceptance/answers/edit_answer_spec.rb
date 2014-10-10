require_relative '../acceptance_helper'

feature 'Автор ответа может редактировать свои ответы' do
  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question)}
  
  scenario 'Гость не может редактировать ответы' do
    visit question_path(question)
    expect(page).to_not have_link 'Редактировать'
  end
  
  describe 'Аутентифицированный пользователь' do
    before do
      sign_in user
      visit question_path(question)  
    end
    
    scenario 'видит ссылку на редактирование ответа' do
      within '.answers' do
        expect(page).to have_link 'Редактировать'
      end
    end

    scenario 'редактирует свой ответ', js: true do
      click_on 'Редактировать'
      within '.answers' do
        fill_in 'Answer', with: 'edited answer'
        click_on 'Save'

        expect(page).to_not have_content answer.body
        expect(page).to have_content 'edited answer'
        expect(page).to_not have_selector 'textarea'
      end

    end

    scenario 'не может редактировать чужой ответ'    
  end

end
