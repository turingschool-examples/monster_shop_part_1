class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user.default?
      redirect_to '/profile'
    elsif current_merchant?
      redirect_to '/merchant/dashboard'
    elsif current_admin?
      redirect_to '/admin/dashboard'
    end
    session[:user_id] = user.id
    flash[:success] = "Welcome, #{user.name}, you are logged in!"
  end
end
