class SessionsController < ApplicationController
	def new

	end

	def create
  user = User.find_by(email: params[:email])
  session[:user_id] = user.id
  flash[:success] = "Welcome, #{user.name}!"
    if user.admin?
      redirect_to '/admin/profile'
      flash[:success] = "Welcome, #{user.name}. You are logged in as an Admin."
    elsif user.merchant?
      redirect_to '/merchants/profile'
      flash[:success] = "Welcome, #{user.name}. You are logged in as a Merchant."
    elsif user.default?
      redirect_to '/users/profile'
      flash[:success] = "Welcome, #{user.name}."
    else
      redirect_to "/"
    end
  end
  
  def destroy
    session.delete(:user_id)
    flash[:success] = "You have been signed out."
    redirect_to "/welcome/home"
	end
end
