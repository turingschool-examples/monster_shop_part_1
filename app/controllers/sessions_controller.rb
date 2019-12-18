class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    login(user)
    session[:user_id] = user.id
    flash[:success] = "Welcome, #{user.name}, you are logged in!"
  end

  def destroy
    session.clear
    flash[:success] = "You have been logged out"
    redirect_to '/'
  end

  private

  def login(user)
    if user.default?
      redirect_to '/profile'
    elsif user.merchant?
      redirect_to '/merchant/dashboard'
    elsif user.admin?
      redirect_to '/admin/dashboard'
    end
  end

end
