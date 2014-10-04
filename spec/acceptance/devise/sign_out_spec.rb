require_relative "../acceptance_helper"

feature "Аутентифицированный пользователь может завершить свою ссесию работы с сайтом" do
  scenario "Аутентифицированный пользователь выходит" do
    sign_in create(:user)
    visit root_path
    click_on "Выход"
    expect(page).to have_content("Выход из системы выполнен.")
    expect(current_path).to eq root_path
  end
  scenario "Гость не может выйти" do
    visit root_path
    expect(page).to_not have_link("Выход", href: destroy_user_session_path)
  end
end
