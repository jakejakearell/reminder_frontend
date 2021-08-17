class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    new_user = User.new(user_params)
    if new_user.save
      session[:user_id] = new_user.id
      redirect_to dashboard_index_path
    else
      flash[:error] = new_user.errors.full_messages.to_sentence
      @user = User.new
      render :new
    end
  end

  private

  def user_params
    params[:user][:email] = params[:user][:email].downcase
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
