class UsersController < ApplicationController
  def new
  end   

  def create
    new_user = User.create!(user_params)
    if user_params[:password] != params[:confirm_password]
      flash.now[:warning]= "Please make sure your passwords match"
      render :new
    else 
      flash[:notice]= "Welcome #{new_user.name}"
      session[:user_id] = new_user.id
      redirect_to '/profile'
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
