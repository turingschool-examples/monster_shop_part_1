class Users::ProfileController < Users::BaseController
  def show
		# @user = User.find(params[:profile])
  end

	def update_password
	  @user = current_user
	  if @user.update(user_params)
	    bypass_sign_in(@user)
	    redirect_to "users/profile"
	  else
	    render "edit"
	  end
	end

	private

 def user_params
	 params.require(:user).permit(:password, :password_confirmation)
 end
end
