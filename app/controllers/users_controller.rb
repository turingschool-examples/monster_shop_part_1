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
    @user = current_user
    render file: '/public/404' unless current_user && current_user.user?
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    if @user.save
      flash[:success] = "Your profile has been updated."
      redirect_to '/profile'
    end
  end

  private

    def user_params
      params.permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
    end

    def password_params
      params.permit(:password, :password_confirmation)
    end
end
