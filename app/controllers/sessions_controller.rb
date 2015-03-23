class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if !user.nil? && user.password == encrypt(params[:session][:password])
      sign_in user
      redirect_to decks_path
    else
      flash.alert = "The email/password combination is incorrect"
      redirect_to new_session_path
    end
  end

  def destroy
    cookies.delete(:user_id)
    redirect_to root_path
  end
end
