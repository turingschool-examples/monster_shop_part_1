class UsersController < ApplicationController

  def index
		@users = User.all
  end

	def profile
		@user = User.find(params[:id])
	end

  def register
	end

	def create
		user = User.create(user_params)
		user.save
		
		redirect_to	"/users"
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
				:password_digest
			)
		end
end
