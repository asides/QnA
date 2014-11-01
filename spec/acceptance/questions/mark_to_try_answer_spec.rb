require_relative '../acceptance_helper'

feature 'Автор вопроса может отметить один ответ как верный' do
  scenario 'Автор отмечает ответ как верный'
  scenario 'Автор удаляет метку верного ответа'
  scenario 'Автор вопроса не может отметить несколько ответов как верные'
  scenario 'Аутентифицированный пользователь не может отмечать ответы других пользователей'
  scenario 'Гость не может отмечать ответы как верные'
end
