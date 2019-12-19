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

  def show
    @user = User.find(session[:user_id])
  end

  def edit
    @new_user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    if user.save
      flash[:notice] = "Data updated successfully"
      redirect_to "/profile"
    else
      flash[:notice] = "Data not saved"
    end
  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
  end
end
