require_relative '../acceptance_helper'

feature 'Добавление файлов к ответу', %q{
  Для того чтобы лучше раскрыть ответ на вопрос
  Я как автор ответа
  Могу добавить файлы к своему ответу
} do

  given!(:user) { create(:user, admin: true) }
  given(:question) { create(:question, user: user) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'Пользователь добавляет файлы к ответу', js: true do
    within 'form#new_answer' do
      fill_in 'Ваш ответ', with: 'text text'
      attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
      click_on 'Ответить на вопрос'
    end

    within '#answers' do
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    end
  end
end
