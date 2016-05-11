class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  helper_method :time_converter

  def time_converter(time)
  daystime = time.day
  hourstime = time.hour
  minutestime = time.min
  
  days = case daystime
    when 1
      "день"
    when 2..4
      "дня"
    when 5..20
      "дней"
    when 21
      "день"
    when 22..24
      "дня"
    when 25..30
      "дней"
    when 31 
      "день"
  end
  
  hours = case hourstime
    when 1
      "час"
    when 2..4
      "часа"
    when 5..9
      "часов"
    when 5..20
      "часов"
    when 21
      "час"
    when 22..24
      "часа"
  end
  
  minutes = case minutestime
    when 1
      "минута"
    when 2..4
      "минуты"
    when 5..20
      "минут"
    when 21
      "минута"
    when 22..24
      "минуты"
    when 25..30
      "минут"
    when 31
      "минута"
    when 32..34
      "минуты"
    when 35..40
      "минут"
    when 41
      "минута"
    when 42..44
      "минуты"
    when 45..50
      "минут"
    when 51
      "минута"
    when 52..54
      "минуты"
    when 55..60
      "минут"
  end

  return "#{daystime} #{days}, #{hourstime} #{hours} и #{minutestime} #{minutes}"

  end



  protected

  def configure_devise_permitted_parameters
    registration_params = [:terms, :email, :password, :password_confirmation, :name, :surname]

    if params[:action] == 'update'
      devise_parameter_sanitizer.for(:account_update) {
          |u| u.permit(registration_params << :current_password)
      }
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.for(:sign_up) {
          |u| u.permit(registration_params)
      }
    end
  end
end
