class UsersController < ApplicationController

  def index
		@users = User.all
  end

	def show
		@user = User.find(session[:id])
	end

  def new
	end

	def create
		new_user = User.create(user_params)
		flash[:success] = "Welcome, #{new_user.name}"
		session[:user_id] = new_user.id
		redirect_to "/"
	end


	private
		def user_params
			params.permit(
				:name,
				:street_address,
				:city,
				:state,
				:zip,
				:email,
				:password
			)
		end
end
