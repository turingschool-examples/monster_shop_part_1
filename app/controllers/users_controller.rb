class UsersController < ApplicationController
  def new
    @user = User.new(user_params)
  end

  def create
    @user = User.create(user_params)
    if @user.save
      flash[:success] = "Welcome, #{@user.name}! You're now registered!"
      session[:user_id] = @user.id
      redirect_to '/profile'
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @user = User.find(session[:user_id])
  end

  private
  def user_params
    params.permit(:name, :address, :city, :state, :zip_code, :email, :password, :password_confirmation)
  end
end
