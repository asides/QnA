require_relative '../acceptance_helper'

feature 'Добавление тегов к вопросу', %q{
  Для того чтобы показать тематику моего вопроса
  Я как автор вопроса
  Могу добавить теги к своему вопросу
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user, tag_list: 'a,b,c') }

  scenario 'Пользователь добавляет теги когда создаёт вопрос' do
    sign_in(user)
    visit new_question_path

    fill_in 'Title', with: 'Test tags for question'
    fill_in 'Body', with: 'It is simple test of tags for best navigation'

    fill_in 'Tag list', with: 'tag_1,tag_2,tag_3'

    click_on 'Сохранить вопрос'

    within('.question .tags') do
      expect(page).to have_content( /tag_\d/, count: 3 )
    end
  end

  scenario 'Пользователь изменяет теги когда редактирует вопрос' do
    sign_in(user)
    visit edit_question_path question

    fill_in 'Tag list', with: 'tag_a'

    click_on 'Сохранить вопрос'

    within('.question .tags') do
      expect(page).to have_content('tag_a')
    end
  end
end
