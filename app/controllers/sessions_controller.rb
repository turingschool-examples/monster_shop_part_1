class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    session[:user_id] = user.id
    flash[:success] = "Welcome, #{user.name}, you are logged in!"
    if current_user.default?
      redirect_to '/profile'
    elsif current_admin?
      redirect_to '/admin/dashboard'
    end
  end

end
