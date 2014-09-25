require "rails_helper"

feature "View index page with lastest questions", %q{
С целью получения информации о последних вопросах,
Я как гость или зарегистрированный пользователь
Могу видеть список последних вопросов на главной странице
} do

  scenario "Посетитель заходит на главную страницу и видит список последних 15 вопросов" do
    questions = create_list(:question, 20)
    visit root_path
    expect(page).to have_css('last_question', count: 15)

  end
end
