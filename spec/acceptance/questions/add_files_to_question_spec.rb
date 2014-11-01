require_relative '../acceptance_helper'

feature 'Добавление файлов к вопросу', %q{
  Для того чтобы лучше объяснить мой вопрос
  Я как автор вопроса
  Могу добавить файлы к своему вопросу
} do

  given(:user) { create(:user) }

  background do
    sign_in(user)
    visit new_question_path
  end

  scenario 'Пользователь добавляет файлы когда создаёт вопрос' do
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Сохранить вопрос'

    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end

end
