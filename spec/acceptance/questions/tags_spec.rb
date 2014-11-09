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
  end

  scenario 'Пользователь добавляет теги когда создаёт вопрос' do

  end

end
