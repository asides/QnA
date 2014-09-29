require "rails_helper"

feature "Аутентифицированный пользователь может завершить свою ссесию работы с сайтом" do
  scenario "Аутентифицированный пользователь выходит" do
    sign_in create(:user)
    visit root_path
    click_on "Выход"
    expect(page).to have_content("Выход из системы выполнен.")
  end
  scenario "Гость не может выйти" do
    visit destroy_user_session_path
    expect(page).to have_content("Выход из системы уже выполнен")
  end
end
