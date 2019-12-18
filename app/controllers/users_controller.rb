class UsersController < ApplicationController
  def new
  end

  def create
    @new_user = User.new(user_params)
    if @new_user.save
      session[:user_id] = @new_user.id
      flash[:success] = "Welcome, #{@new_user.name}! You are now logged in."
      redirect_to '/profile'
    else
      flash.now[:error] = @new_user.errors.full_messages.to_sentence
      render :new
    end
  end

  def show

  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
  end
end
