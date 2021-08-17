class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email].downcase)

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_index_path
    else
      flash[:message] = 'The email or password you entered is incorrect'
      redirect_to root_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
