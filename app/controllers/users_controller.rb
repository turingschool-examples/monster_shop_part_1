class UsersController < ApplicationController
  def new
     @form_info = session[:incomplete_user] || User.new(
      name: 'name',
      address: 'address',
      city: 'city',
      state: 'state',
      zip: '00000',
      email: 'email@email.com'
    )
  end

  def create
    @new_user = User.new(user_params)
    if user_params[:password] != params[:confirm_password]
      flash.now[:warning]= "Please make sure your passwords match"
      render :new
    end
    if @new_user.save
      flash[:notice]= "Welcome #{new_user.name}"
      session[:user_id] = @new_user.id
      redirect_to '/profile'
    elsif !User.find_by_email(params[:email])
      flash[:notice] = 'Please fill all required fields'
      redirect_back fallback_location: "/register"
      session[:incomplete_user] = @new_user
    else
      flash[:notice] = 'Email address in use'
      redirect_back fallback_location: "/register"
      session[:incomplete_user] = @new_user
    end
  end

  def show
    @user = User.find(session[:user_id])
  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password)
  end
end
