# require_relative '../acceptance_helper'

# feature 'Автор комментария может редактировать свои комментарии' do
#   given(:user) { create(:user) }
#   given(:other) { create(:user) }

#   given!(:question) { create(:question, user: user) }
#   given!(:question2) { create(:question, user: user) }

#   given!(:answer) { create(:answer, question: question, user: user)}
#   given!(:answer2) { create(:answer, question: question2, user: other)}

#   scenario 'Гость не может редактировать ответы' do
#     visit question_path(question)

#     within '.answers' do
#       expect(page).to_not have_link 'Редактировать'
#     end
#   end

#   describe 'Аутентифицированный пользователь' do
#     before do
#       sign_in user
#       visit question_path(question)
#     end

#     scenario 'видит ссылку на редактирование ответа' do
#       within '.answers' do
#         expect(page).to have_link 'Редактировать'
#       end
#     end

#     scenario 'редактирует свой ответ', js: true do
#       within '.answers' do
#         click_on 'Редактировать'
#         fill_in 'Edit you answer', with: 'edited answer', match: :first
#         click_on 'Save answer'
#         expect(page).to_not have_content answer.body
#         expect(page).to have_content 'edited answer'
#       end
#     end

#     scenario 'не может редактировать чужой ответ' do
#       visit question_path(question2)
#       within '.answers' do
#         expect(page).to_not have_link 'Редактировать'
#       end
#     end
#   end

# end
