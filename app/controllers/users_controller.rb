class UsersController < ApplicationController
  def new
    if signed_in?
      flash.alert = "You are signed in. Please sign out to create a new account."
      redirect_to decks_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      if signed_in?
        flash.alert = "You are signed in. Please sign out to create a new account."
      else
        @user.password = encrypt(@user.password)
        @user.save
        sign_in @user
      end
      redirect_to decks_path
    else
      display_errors
      redirect_to new_user_path
    end
  end

  def show
    @user = current_user
    unless @user
      redirect_to root_path
    end
  end

  def destroy
    User.find(params[:id]).destroy
    sign_out
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def display_errors
    if @user.errors[:email]
      flash.alert = "The email address #{@user.errors[:email][0]}."
    elsif @user.errors[:password]
      flash.alert = "Your password #{@user.errors[:password][0]}."
    else
      flash.alert = "Something is wrong with your info, please fix it."
    end
  end
end
