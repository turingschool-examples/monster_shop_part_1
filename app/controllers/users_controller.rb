class UsersController < ApplicationController
  def new

    
  end

  def create
    @new_user = User.new(user_params)
    if @new_user.save
      flash[:notice]= "Welcome #{@new_user.name}"
      session[:user_id] = @new_user.id
      redirect_to '/profile'
    else
      flash[:notice] = @new_user.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit_pw
    @user = User.find(current_user) if current_user
    render '/errors/404' unless current_user
  end

  def update
    user = User.find(current_user)
    user.update(user_params)
  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
  end
end
