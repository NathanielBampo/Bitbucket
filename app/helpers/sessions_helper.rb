module SessionsHelper
  # Осуществляется вход данного пользователя
  def log_in(user)
    session[:user_id] = user.id
  end

  # Поиск существуещго пользователя в сеансе
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # if user exist ,return true
  def logged_in?
    !current_user.nil?
  end

end
