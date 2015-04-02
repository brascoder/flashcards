require "digest/md5"

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    if cookies[:user_id]
      user_id = cookies.signed[:user_id]
      User.find_by_id(user_id)
    end
  end
  helper_method :current_user

  def sign_in user
    cookies.signed[:user_id] = user.id
  end

  def sign_out
    cookies.delete(:user_id)
    redirect_to root_path
  end

  def authenticate
    redirect_to new_session_path unless signed_in?
  end

  def signed_in?
    current_user
  end
  helper_method :signed_in?

  def encrypt string
    Digest::MD5.hexdigest string
  end
end
