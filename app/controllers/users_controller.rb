class UsersController < ApplicationController
  def index
  end

  def new
	end

	def create
		User.create(user_params)
		redirect_to	'/profile'
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