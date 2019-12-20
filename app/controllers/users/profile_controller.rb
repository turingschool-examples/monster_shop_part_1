class Users::ProfileController < Users::BaseController
  def show
  end

	def edit
	end

	def update
		user = User.create(user_params)
		redirect_to '/users/profile'
	end

	private

	def user_params
		params.permit(
		:name,
		:address,
		:city,
		:state,
		:zip,
		:email
	)

	end
end
