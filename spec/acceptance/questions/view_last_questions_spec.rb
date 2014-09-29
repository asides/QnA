require "rails_helper"

feature "Посетитель может просматривать список вопросов на главной" do

  scenario "Посетитель видит список последних вопросов на главной странице" do
    questions = create_list(:question, 20)
    visit root_path
    expect(page).to have_css('last_question', count: 15)
  end

  scenario "Посетитель видит сообщение если вопросов в базе нет" 

  scenario "Посетитель видит общее количество вопросов в базе на главной странице"

end
