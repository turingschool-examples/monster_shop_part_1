class SessionsController < ApplicationController
	def new

	end

	def create
		user = User.find_by(name: params[:name])
		if user.authenticate(params[:password])
			session[:user_id] = user.id
			flash[:success] = "Welcome, #{user.name}!"
			redirect_to '/'
		else
			flash[:error] = "Sorry, your credentials are bad."
			render :new 
	end
end
