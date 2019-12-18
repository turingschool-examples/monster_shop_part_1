class SessionsController < ApplicationController
	def new

	end

	def create
  user = User.find_by(email: params[:email])
  session[:user_id] = user.id
  flash[:success] = "Welcome, #{user.name}!"
		if user.admin?
			redirect_to '/admin/profile'
		elsif user.merchant?
			redirect_to '/merchants/profile'
		end
	end
end
