require_relative '../acceptance_helper'

feature 'Посетитель может просматривать список всех тегов на отдельной странице' do

  given!(:tags) { create_list( :tag, 5 ) }

  scenario 'Посетитель видит ссылку на страницу с тегами' do
    visit root_path
    expect(page).to have_link('Tags', href: tags_path)
  end

  scenario 'Посетитель видит существующие теги на странице тегов' do
    visit tags_path
    expect(page).to have_content(/tag\d/, count: 5)
  end

end
