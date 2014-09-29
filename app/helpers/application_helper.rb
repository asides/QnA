module ApplicationHelper
  def display_user_link
    if current_user
      link_to "Выход", destroy_user_session_path, method: :delete
    else
      link_to "Войти", new_user_session_path
      link_to "Регистрация", new_user_session_path
    end
  end
end
