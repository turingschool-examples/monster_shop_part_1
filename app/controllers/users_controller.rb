class UsersController < ApplicationController
  def new
  end

  def create
    user = User.create(user_params)

    if user.save
      flash[:success] = "Welcome, #{user.name}! You're now registered!"
      redirect_to '/profile'
    else
      render :new
    end
  end

  private
  def user_params
    params.permit(:name, :address, :city, :state, :zip_code, :email, :password, :password_confirmation)
  end
end