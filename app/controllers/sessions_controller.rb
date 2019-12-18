class SessionsController < ApplicationController
	def new

	end

	def create
  user = User.find_by(email: params[:email])
  session[:user_id] = user.id
  flash[:success] = "Welcome, #{user.name}!"
	if user.admin?
		redirect_to '/admin/profile'
		flash[:success] = "Welcome, #{user.name}!"
	elsif user.merchant?
		redirect_to '/merchants/profile'
		flash[:success] = "Welcome, #{user.name}!"
	elsif user.default?
		redirect_to '/users/profile'
		flash[:success] = "Welcome, #{user.name}!"
	else
		redirect_to "/banana"
	end
	end
end
