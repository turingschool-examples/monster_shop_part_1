class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :cart

  def cart
    @cart ||= Cart.new(session[:cart] ||= Hash.new(0))
  end

	helper_method :current_user, :current_default?, :current_admin?

	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

  def current_admin?
    return false unless session[:user_id]
    @user = User.find(session[:user_id])
    @user.admin?
  end

  def current_merchant?
    return false unless session[:user_id]
    merch = User.find(session[:user_id])
    merch.merchant?
  end

  def current_default?
    return false unless session[:user_id]
    @user = User.find(session[:user_id])
    @user.default?
  end
end
