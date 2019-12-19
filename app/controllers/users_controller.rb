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
    if current_user
      @user = User.find(session[:user_id])
    else
      render file: '/public/404'
    end
  end

  def edit
  end

  def update
    if params.include?(:password) && params[:password] == params[:password_confirmation]
      current_user.update(user_params)
      redirect_to "/profile"
      flash[:notice] = "Your password has been updated."
    elsif params[:password] != params[:password_confirmation]
      redirect_to "/user/password/edit"
      flash[:error] = "Password and password confirmation do not match."
    end
  end

  private
  def user_params
    params.permit(:name, :address, :city, :state, :zip_code, :email, :password, :password_confirmation)
  end
end
