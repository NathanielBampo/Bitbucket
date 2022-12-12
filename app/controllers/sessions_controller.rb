class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email.downcase]) # Find equal email

    if user && user.authenticate(params[:session][:password]) # test equal password
      session[:user_id] = user.id

      # User input and render profile user
      flash[:success] = "You log in"
      redirect_to user_path(user)
    else
      flash.now[:danger] = 'Invalide email or password combination'
      render "new" # render form_field new session and print error
    end
  end

  def destroy
    session.delete(:user_id)

    flash[:danger] = "You log out account"
    redirect_to root_path
  end
end
