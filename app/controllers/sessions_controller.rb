class SessionsController < ApplicationController
	def new

	end

	def create
  user = User.find_by(email: params[:email])
  session[:user_id] = user.id
  flash[:success] = "Welcome, #{user.name}!"
	if user.admin?
		redirect_to '/admin/dashboard'
		flash[:success] = "Welcome admin, #{user.name}!"
	elsif user.merchant?
		redirect_to '/merchants/dashboard'
		flash[:success] = "Welcome merchant, #{user.name}!"
	elsif user.default?
		redirect_to '/users/profile'
		flash[:success] = "Welcome user, #{user.name}!"
	else
		redirect_to "/"
	end
	end
end
