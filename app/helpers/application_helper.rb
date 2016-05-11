module ApplicationHelper
	protected

	def check_if_admin
    if user_signed_in?
      raise 'Доступ только для администрации!' unless current_user.is_admin?
    else
      # or you can use the authenticate_user! devise provides to only allow signed_in users
      raise 'Пожалуйста, авторизируйтесь!'
    end
  end
end
