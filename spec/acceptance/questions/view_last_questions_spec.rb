require_relative '../acceptance_helper'

feature 'Посетитель может просматривать список вопросов на главной' do

  scenario 'Посетитель видит список последних вопросов на главной странице' do
    questions = create_list(:question, 3)
    expect(Question.all).to_not be_empty
    visit root_path
    expect(page).to have_content('Question title', count: 3)
  end

  scenario 'Посетитель видит сообщение если вопросов в базе нет' do
    visit root_path
    expect(page).to have_content 'Еще не создан ни один вопрос'
  end

end
