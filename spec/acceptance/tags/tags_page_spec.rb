require_relative '../acceptance_helper'

feature 'Посетитель может просматривать список всех тегов на отдельной странице' do

  scenario 'Посетитель видит ссылку на страницу с тегами' do
    visit root_path
    expect(page).to have_link('Tags', href: tags_path)
  end

  given!(:tags) { create_list( :tag, 5 ) }

  scenario 'Посетитель видит существующие теги на странице тегов' do
    visit tags_path
    expect(page).to have_content(/Tag-\d/, count: 5)
  end

end
