require 'rails_helper'

feature "Регистрация пользователя" do

  scenario "Новый пользователь регистрируется" do
    visit root_path
    
    click_on "Регистрация"
    
    expect(current_path).to eq new_user_registration_path
    
    fill_in "Name", with: "UserName"
    fill_in "Email", with: "user@test.com"
    fill_in "Password", with: "12345678", match: :prefer_exact
    fill_in "Password confirmation", with: "12345678", match: :prefer_exact
    click_on "Зарегистрироваться"
    
    # expect(current_path).to eq root_path
    expect(page).to have_content "Вы успешно зарегистрировались"
    
    within "#user_info" do
      expect(page).to have_content "UserName"
    end
  end
  given(:user) { create(:user) }
  scenario "Существующий пользователь пытается зарегистрироваться" do
    sign_in user
    visit new_user_registration_path
    expect(page).to have_content "Вы уже вошли в систему"
  end
end
