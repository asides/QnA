require_relative '../acceptance_helper'

feature 'Добавление тегов к вопросу', %q{
  Для того чтобы показать тематику моего вопроса
  Я как автор вопроса
  Могу добавить теги к своему вопросу
} do

  given(:user) { create(:user) }

  background do
    sign_in(user)
    visit new_question_path
    fill_in 'Title', with: 'Test tags for question'
    fill_in 'Body', with: 'It is simple test of tags for best navigation'
  end

  scenario 'Пользователь добавляет теги когда создаёт вопрос' do
    fill_in 'Tags', with: 'tag_a,tab_b,tag_c'

    click_on 'Сохранить вопрос'

    expect(page).to have_content( 'tag_a tag_b tag_c' )
  end

end
